vm_publisher_name     = "Canonical"
vm_offer              = "UbuntuServer"
vm_sku                = "16.04.0-LTS"
vm_version            = "latest"
availability_set_name = "CCD-DATA-0-AV-SET"

storageAccountType     = "Default"
dataStorageAccountType = "Standard"
vmDataDiskCount        = "2"

lb_private_ip_address = "10.112.153.253"
soc_vault_name        = "soc-prod"
soc_vault_rg          = "soc-core-infra-prod-rg"

ipconfig_name = "ipconfig1"

dynatrace_instance  = "yrk32651"
dynatrace_hostgroup = "PERF_CFT"

elastic_search_clusters = {
  default = {
    instance_count = 4
    name_template  = "ccd-data-%d"
    data_disks     = 2
    private_ip_allocation = {
      0 = "10.112.153.7"
      1 = "10.112.153.6"
      2 = "10.112.153.9"
      3 = "10.112.153.5"
    }
    lb_private_ip_address = "10.112.153.253"
    storage_account_type  = "StandardSSD_LRS"
  }
}

nsg_security_rules = {
  SSH = {
    name                                       = "SSH"
    description                                = "Allows SSH traffic"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "22"
    source_address_prefix                      = "VirtualNetwork"
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
  },
  ElasticClusterTransport = {
    name                                       = "ElasticClusterTransport"
    description                                = "Allows ElasticSeach communication only between nodes"
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = null
    destination_port_ranges                    = ["9200", "9300"]
    source_address_prefix                      = null
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
    source_application_security_group_ids      = "id"
  },

  LB_To_ES = {
    name                                       = "LB_To_ES"
    description                                = "Allows ElasticSeach queries from the LoadBalancer.  Needed for LoadBalancer healthchecks."
    priority                                   = 160
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = null
    destination_port_ranges                    = ["9200", "9300"]
    source_address_prefix                      = "AzureLoadBalancer"
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
  },

  Bastion_To_ES = {
    name                                       = "Bastion_To_ES"
    description                                = "Allow Bastion access for debugging elastic queries on development platforms"
    priority                                   = 200
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "9200"
    source_address_prefix                      = "10.11.72.32/27"
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
  },

  App_To_ES = {
    name                                       = "App_To_ES"
    description                                = "Allow Apps to access the ElasticSearch cluster"
    priority                                   = 210
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "9200"
    source_address_prefix                      = "10.112.140.0/22"
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
  },

  AKS_To_ES = {
    name                                       = "AKS_To_ES"
    description                                = "Allow AKS to access the ElasticSearch cluster"
    priority                                   = 215
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "9200"
    source_address_prefix                      = null
    source_address_prefixes                    = ["10.48.80.0/20", "10.48.64.0/20"]
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
  },

  Jenkins_To_ES = {
    name                                       = "Jenkins_To_ES"
    description                                = "Allow Jenkins to access the ElasticSearch cluster for testing"
    priority                                   = 220
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = ["9200", "22"]
    source_address_prefix                      = "10.10.76.0/23"
    destination_address_prefix                 = null
    destination_application_security_group_ids = "id"
  },

  Mgmt_Perf_Test_To_ES = {
    name                                       = "Mgmt_Perf_Test_To_ES"
    description                                = "Allow Management Performance Testing to access the ElasticSearch cluster"
    priority                                   = 225
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "9200"
    source_address_prefix                      = "10.112.160.0/24"
    destination_address_prefix                 = "10.112.153.0/24"
    destination_application_security_group_ids = "id"
  },

  Bastion_To_VMs = {
    name                       = "Bastion_To_VMs"
    description                = "Allow Bastion SSH access overridding templates broad SSH access"
    priority                   = 230
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "10.11.72.32/27"
    destination_address_prefix = "10.112.153.0/24"
  },

  DenyAllOtherTraffic = {
    name                       = "DenyAllOtherTraffic"
    description                = "Deny all traffic that is not Elastic or SSH from anywhere"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
