# ccd-elastic-search: repository guide (how the code works)

## What this repo does (in practice)

This repository provisions and configures the CCD Elasticsearch cluster in Azure by combining:

- **Terraform** to create and manage Azure resources (VMs via an external module, networking controls, internal load balancer, Key Vault integration).
- **Jenkins pipelines** to orchestrate Terraform plan/apply and run post-provision configuration.
- **Ansible** to configure disks/OS and Elasticsearch on the provisioned VMs.

## How to change an environment (quick guide)

Most changes are made by updating the environment `*.tfvars` file (e.g. `demo.tfvars`, `aat.tfvars`, `perftest.tfvars`, `ithc.tfvars`, `prod.tfvars`).

Typical changes and where to make them:

- **Add/remove nodes, change node IPs, change disk layout**  
  → update the relevant `*.tfvars` (and expect disruption for IP changes).

- **Change who can connect (NSG rules)**  
  → update the `nsg_security_rules` map in the relevant `*.tfvars`.

- **Change load balancer behaviour (probes/rules/ports)**  
  → update `lb.tf` and/or the repo-local module(s) under `modules/`.

- **Change VM provisioning behaviour (SKU/image/NIC/disk attachment primitives)**  
  → update the external module reference and inputs in `vm.tf` (note: module changes can have wide impact).

- **Change Elasticsearch configuration**  
  → update Ansible templates/roles under `ansible/` (not the Terraform).

- **Change pipeline behaviour / stages / parameters**  
  → update `Jenkinsfile_CNP` and/or `Jenkinsfile_parameterized`.

## Code map (where logic lives)

Terraform (Azure provisioning):
- `init.tf` — provider/backend initialisation.
- `main.tf` — overall resource/module composition.
- `networking.tf` — network lookups and controls (subnet, NSG/ASG).
- `vm.tf` — VM module wiring (delegates primitives to `hmcts/ccd-module-elastic-search`).
- `lb.tf` — internal load balancer configuration.
- `variables.tf` — variable declarations.
- `modules/` — repo-local Terraform modules.
- `import_files/`, `moved-lb-prod.tf`, `prod_imports2.tf` — state import/move artefacts (traceability/history).

Ansible (host/service configuration):
- `ansible/diskmount.yml` — disk setup/mounting.
- `ansible/main.yml` — entry playbook.
- `ansible/elasticsearch.yml.j2` — Elasticsearch config template.
- `ansible/elasticsearch-demo-int.yml.j2` — demo-int variant template.
- `ansible/roles/` — roles used by playbooks.

Pipelines:
- `Jenkinsfile_CNP` — Jenkins pipeline for CNP deployments.
- `Jenkinsfile_parameterized` — Jenkins pipeline with parameters (used for ad-hoc or controlled runs).

## Key constraints / “gotchas”

- **Static IPs**: node and LB IPs are typically set in `*.tfvars`. Changing them is disruptive.
- **Environment drift**: NSG rules are defined per environment; keep parity where intended.
- **External module dependency**: changes to `hmcts/ccd-module-elastic-search` (or its pinned ref) can change VM behaviour across all environments.
- **State/import history files**: `moved-lb-prod.tf` / `prod_imports2.tf` exist for a reason; treat edits cautiously.

## Monitoring implementation note (XDR)

Monitoring is provided by **Palo Alto Cortex XDR** agents installed during VM bootstrap:

- Installed by `hmcts/terraform-module-vm-bootstrap` via `files/scripts/linux_run_script.sh`
- Controlled by `RUN_XDR_AGENT=true`

## TODOs (nice improvements)

- Add explicit Jenkins job links/names for each environment.
- Add repo-specific runbook links for common ops tasks (restart/scale/failure modes), if/when available.