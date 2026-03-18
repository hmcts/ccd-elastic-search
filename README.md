# CCD Elasticsearch cluster (Azure)

This repository provisions and configures the **internal CCD Elasticsearch cluster** in Azure.

It contains:
- Terraform to create Azure infrastructure (resource groups, networking controls, internal load balancer, Key Vault integration)
- Jenkins pipelines to run Terraform and apply configuration
- Ansible playbooks to configure disks/OS and Elasticsearch on the provisioned VMs

## Environments

Deployments are environment-specific using `*.tfvars` (for example: `demo`, `aat`, `perftest`, `ithc`, `prod`).  
There is also an optional `demo-int` deployment path controlled via variables.

## High-level architecture (summary)

- **Compute:** Linux VMs (Elasticsearch data nodes), created via `hmcts/ccd-module-elastic-search`
- **Networking:** existing core-infra VNet/subnet (`elasticsearch`), protected by NSG rules and ASG association
- **Ingress:** internal Azure Load Balancer (private IP) forwarding:
  - TCP 9200 (Elasticsearch HTTP)
  - TCP 9300 (Elasticsearch transport / node-to-node)
- **Service discovery:** endpoint details are written to Azure Key Vault:
  - `ccd-ELASTIC-SEARCH-URL` (internal LB private IP)
  - `ccd-ELASTIC-SEARCH-DATA-NODES-URL` (comma-separated node URLs)

## Deployment

Deployments are performed via Jenkins pipelines (`Jenkinsfile_*`) which:
- run Terraform using the HMCTS infrastructure pipeline library
- retrieve secrets from Azure Key Vault for SSH access
- run Ansible playbooks (e.g. `ansible/diskmount.yml`, `ansible/main.yml`) to configure hosts and Elasticsearch

## Monitoring and logging

- The VMs are monitored in **Palo Alto Cortex XDR** via **XDR agents installed on each node** (installed during VM bootstrap using `hmcts/terraform-module-vm-bootstrap` / `files/scripts/linux_run_script.s` if RUN_XDR_AGENT=true has been set).
- Basic VM metrics are also available via Azure monitoring/VM Insights.

## Further documentation

- [Repository guide](docs/Repo-guide.md)

## Ops runbooks and guides

- [Elastic-Search-and-Logstash](https://hmcts.github.io/ops-runbooks/Elastic-Search-and-Logstash/index.html)
- [Patching CCD ELK VMs](https://hmcts.github.io/ops-runbooks/Patching/ccd-elk-vms.html)
- [XDR Agent Installation - HMCTS](https://hmcts.github.io/ops-runbooks/Services/xdr-agent-hmcts.html#xdr-agent-installation-hmcts)
- [Deleting a case from CCD Datastore Database](https://hmcts.github.io/ops-runbooks/database/deleting-cases-from-ccd-datastore.html)