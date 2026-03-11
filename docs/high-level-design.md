# High Level Design (HLD): CCD Elasticsearch cluster (Azure)

- **Repository:** `hmcts/ccd-elastic-search`
- **Audience:** CCD team (service owners), PlatOps/SRE
- **Last updated:** 2026-03-09

## 1. Purpose and scope

This repository provisions and configures an **internal Elasticsearch cluster for CCD** in Azure.

Scope includes:
- Terraform-managed Azure infrastructure for the cluster (resource group(s), networking controls, internal load balancer, key vault secrets).
- VM provisioning for Elasticsearch nodes using an external Terraform module.
- Ansible playbooks executed by Jenkins pipelines to perform OS/disk and Elasticsearch configuration.

Out of scope (but dependencies):
- The **core infra VNet/subnet** the cluster attaches to.
- The external module `hmcts/ccd-module-elastic-search` which creates the VM primitives.
- Consumers of the cluster (CCD applications) other than describing connectivity.

## 2. Environments

This repo supports multiple environments via `*.tfvars`, e.g.:
- `demo.tfvars`
- `aat.tfvars`
- `perftest.tfvars`
- `ithc.tfvars`
- `prod.tfvars`

Each environment defines:
- Node names and private IPs
- Load balancer private IP
- Managed disks per node (LUNs)
- NSG security rules (data-driven map)

There is also an **optional `demo-int` deployment path** controlled by variables (e.g. `enable_demo_int` / `enable_demo_int_deployment`), which creates a separate resource group and load balancer resources for demo-int.

## 3. High-level architecture

### 3.1 Logical view

**Azure resources (Terraform):**
- Resource Group:
  - `ccd-elastic-search-<env>` (always)
  - Optional demo-int RG (name via variable)
- Compute:
  - Multiple Linux VMs representing Elasticsearch data nodes (`ccd-data-0..N`)
  - VMs are created via external module: `github.com/hmcts/ccd-module-elastic-search.git`
- Storage:
  - Managed data disks attached per VM (count/type varies by environment)
- Networking:
  - Uses existing **core infra VNet** `core-infra-vnet-<env>` in `core-infra-<env>`
  - Uses subnet named `elasticsearch`
  - Application Security Group (ASG) applied to node NICs
  - Network Security Group (NSG) with rules defined via tfvars
  - Internal Standard Load Balancer with static private IP
    - forwards TCP **9200** (HTTP) and **9300** (transport)
- Secrets:
  - Reads from Key Vault (SSH keys/tokens)
  - Writes back connection information (LB IP / node URL list) as Key Vault secrets

**Configuration (Jenkins + Ansible):**
- Jenkins pipelines run Ansible playbooks against the provisioned VMs to:
  - mount/configure disks
  - configure Elasticsearch (and related components/config)

### 3.2 Network / traffic flows (simplified)

1. **Clients (CCD apps / AKS / allowed internal sources)** connect to:
   - **Internal LB private IP** on TCP **9200** (Elasticsearch HTTP)
2. **Elasticsearch node-to-node** traffic uses:
   - TCP **9300** (transport)
3. NSG rules restrict inbound access to required sources only (defined per environment).

## 4. Terraform design

### 4.1 Key inputs and parameterisation

Primary variables include:
- `env`, `location`, `subscription`
- node definitions: `vms` (map containing name, ip, managed_disks)
- `lb_private_ip_address`
- `nsg_security_rules` (map of rule objects)
- Elasticsearch config toggles (e.g., version and additional YAML strings)

Environment configuration is driven by `*.tfvars` committed to the repo.

### 4.2 Dependencies / data sources

Terraform uses:
- `azurerm_virtual_network` data source for `core-infra-vnet-<env>`
- `azurerm_subnet` data source for subnet `elasticsearch`
- `azurerm_key_vault` data source for the relevant Key Vault (name derived from env conventions)

### 4.3 Resource groups

- Main resource group is created per environment: `ccd-elastic-search-<env>`
- Optional additional RG for demo-int is created when demo-int is enabled.

### 4.4 Compute (Elasticsearch nodes)

VMs are provisioned via an external module:
- `source = "github.com/hmcts/ccd-module-elastic-search.git?ref=main"`

The module is passed:
- subnet id
- static private IP addresses for each node
- managed disk definitions
- admin SSH key (from Key Vault)
- shared tagging

### 4.5 Load Balancer

An internal Terraform module in this repo provisions:
- `azurerm_lb` (Standard, zonal)
- backend pool and backend addresses based on VM IP map
- probes and rules for:
  - 9200 (http)
  - 9300 (transport)

There is a “main” LB for each environment and an optional demo-int LB.

### 4.6 Security (NSG / ASG)

- ASG is created and associated with VM NICs.
- NSG is created and associated with VM NICs.
- NSG rules are generated from `var.nsg_security_rules`, allowing environment-specific access controls.

This design makes security policy:
- explicit
- environment-specific
- version-controlled (via tfvars)

### 4.7 Tagging / lifecycle

The repo uses HMCTS common tags (`terraform-module-common-tags`).
For sandbox, an `expiresAfter` tag is applied (far-future date used in code) to satisfy platform tagging requirements.

## 5. Secrets and service discovery (Key Vault)

### 5.1 Read from Key Vault

Terraform (and/or Jenkins) reads:
- Elasticsearch SSH public/private key material (for node access / config)
- Dynatrace token
- Alerts email (where configured)

### 5.2 Write to Key Vault

Terraform writes:
- `ccd-ELASTIC-SEARCH-URL` = internal LB private IP
- `ccd-ELASTIC-SEARCH-DATA-NODES-URL` = comma-separated internal node URLs (constructed from naming convention)

These secrets allow consumers and operational tooling to discover endpoints without hard-coding them elsewhere.

## 6. Deployment and operations

### 6.1 Pipelines

This repository contains Jenkins pipelines (`Jenkinsfile_*`) that:
- run Terraform via the HMCTS infrastructure pipeline library
- fetch secrets from Azure Key Vault for Ansible SSH access
- run Ansible playbooks:
  - `ansible/diskmount.yml`
  - `ansible/main.yml`

There is also a GitHub Actions workflow for stale issue/PR management; infra deployment is driven by Jenkins in the current design.

### 6.2 Day-2 ownership responsibilities

CCD ownership should cover:
- Terraform changes:
  - node count / IP changes
  - NSG rules
  - load balancer configuration
  - tag policy adherence
- Ansible changes:
  - disk layout/mounts
  - Elasticsearch configuration changes (including additional YAML snippets)
- Safe rollout practices:
  - plan-only review before apply
  - change windows for prod
  - validation steps after apply (health checks, connectivity tests)

### 6.3 Key operational risks / gotchas

- **Static IPs** for nodes and LB in tfvars: changing these is disruptive and requires coordination.
- **NSG rules are environment-specific**: ensure parity where intended.
- **External module dependency** (`ccd-module-elastic-search`): module changes can affect cluster behaviour.
- **Base image references in tfvars** may be legacy (e.g., older Ubuntu SKU): validate support before changes.

## 7. Validation

Minimum validation after deployment:
- Confirm LB exists, frontend IP matches expected private IP.
- Confirm backend pool contains the expected node IPs.
- Confirm NSG rules match expected sources/ports.
- Confirm Key Vault secrets were updated:
  - `ccd-ELASTIC-SEARCH-URL`
  - `ccd-ELASTIC-SEARCH-DATA-NODES-URL`
- Confirm Ansible completed successfully and Elasticsearch is reachable on 9200 from allowed networks.

## 8. Peer review

Acceptance criterion: “HLD has been peer reviewed”.

Recommended reviewers:
- CCD tech lead / CCD platform owner
- PlatOps engineer familiar with HMCTS Azure + Jenkins infra pipeline
- Security/networking reviewer (optional) for NSG rule intent

Review checklist:
- Correct environment coverage (demo/aat/perftest/ithc/prod + demo-int behaviour).
- Correct data sources (core-infra VNet/subnet naming).
- Key Vault read/write secrets align with expectations.
- LB ports and connectivity requirements are correct.
- Clarify authoritative Jenkins job names/links (to be added below).

## 9. Open items / TODOs (to complete with CCD)

- [ ] Add explicit Jenkins job links/names used to deploy each environment (source of truth).
- [ ] Confirm which consumers read `ccd-ELASTIC-SEARCH-URL` and from which Key Vault.
- [ ] Add runbook links (restart procedure, scaling procedure, failure modes) if/when available.