locals {
  jira_file_hash         = md5(file("${path.module}/scripts/configure-jira-vm.sh"))
  function_file_hash     = md5(file("${path.module}/scripts/functions.sh"))
  crowd_file_hash        = md5(file("${path.module}/scripts/configure-crowd-vm.sh"))
  gluster_file_hash      = md5(file("${path.module}/scripts/configure-gluster-vm.sh"))
  confluence_private_ips = join(",", [for k, v in var.vms : v.private_ip_address if can(regex("confluence", k))])
  confluence_file_hash   = md5(file("${path.module}/scripts/configure-confluence-vm.sh"))
  ssl_version            = data.azurerm_key_vault_secret.ssl_cert.version
}
