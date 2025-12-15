vm_publisher_name     = "Canonical"
vm_offer              = "UbuntuServer"
vm_sku                = "16.04.0-LTS"
vm_version            = "latest"
availability_set_name = "CCD-DATA-0-AV-SET"

storageAccountType     = "Default"
dataStorageAccountType = "Standard"
vmDataDiskCount        = "2"

lb_private_ip_address = "10.112.53.252"
soc_vault_name        = "soc-prod"
soc_vault_rg          = "soc-core-infra-prod-rg"

ipconfig_name = "ipconfig1"

elastic_search_clusters = {
  default = {
    instance_count = 4
    name_template  = "ccd-data-%d"
    data_disks     = 2
    private_ip_allocation = {
      0 = "10.112.53.5"
      1 = "10.112.53.9"
      2 = "10.112.53.6"
      3 = "10.112.53.7"
    }
    lb_private_ip_address = "10.112.53.252"
    storage_account_type  = "StandardSSD_LRS"
  }
  upgrade = {
    instance_count = 4
    name_template  = "ccd-data-upgrade-%d"
    data_disks     = 2
    private_ip_allocation = {
      0 = "10.112.53.100"
      1 = "10.112.53.101"
      2 = "10.112.53.102"
      3 = "10.112.53.103"
    }
    lb_private_ip_address = "10.112.53.253"
    storage_account_type  = "StandardSSD_LRS"
    # Use Ubuntu 24.04 LTS for upgrade cluster (different from default cluster's 16.04)
    vm_publisher_name        = "Canonical"
    vm_offer                 = "ubuntu-24_04-lts"
    vm_sku                   = "server"
    vm_version               = "latest"
    vm_size                  = "Standard_D4ds_v5"  # New VM size to meet SKU requirements https://github.com/hmcts/azure-policy/blob/master/policies/allowed_vm_sku/README.md
    attachment_create_option = "Attach"
    privateip_allocation     = "Static"
  }
  # Example: Add additional cluster for upgrade testing
  # upgrade = {
  #   instance_count = 4
  #   name_template  = "ccd-data-upgrade-%d"
  #   data_disks     = 2
  #   private_ip_allocation = {
  #     0 = "10.100.157.20"
  #     1 = "10.100.157.21"
  #     2 = "10.100.157.22"
  #     3 = "10.100.157.23"
  #   }
  #   lb_private_ip_address = "10.100.157.253"
  # }
}
# vms = {
#   ccd-data-0 = {
#     name = "ccd-data-0"
#     ip   = "10.112.53.5"
#     managed_disks = {
#       disk1 = {
#         name                = "ccd-data-0-datadisk1"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "0"
#       }
#       disk2 = {
#         name                = "ccd-data-0-datadisk2"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "1"
#       }
#     }
#   }
#   ccd-data-1 = {
#     name = "ccd-data-1"
#     ip   = "10.112.53.9"
#     managed_disks = {
#       disk1 = {
#         name                = "ccd-data-1-datadisk1"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "0"
#       }
#       disk2 = {
#         name                = "ccd-data-1-datadisk2"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "1"
#       }
#     }
#   }
#   ccd-data-2 = {
#     name = "ccd-data-2"
#     ip   = "10.112.53.6"
#     managed_disks = {
#       disk1 = {
#         name                = "ccd-data-2-datadisk1"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "0"
#       }
#       disk2 = {
#         name                = "ccd-data-2-datadisk2"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "1"
#       }
#     }
#   }
#   ccd-data-3 = {
#     name = "ccd-data-3"
#     ip   = "10.112.53.7"
#     managed_disks = {
#       disk1 = {
#         name                = "ccd-data-3-datadisk1"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "0"
#       }
#       disk2 = {
#         name                = "ccd-data-3-datadisk2"
#         resource_group_name = "ccd-elastic-search-ithc"
#         disk_lun            = "1"
#       }
#     }
#   }
# }

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
    description                                = "Allow Bastion access for debugging elastic queries on ITHC platform"
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
    source_address_prefix                      = "10.112.12.0/22"
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
    source_address_prefixes                    = ["10.11.192.0/20", "10.11.208.0/20"]
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
    destination_port_range                     = "9200"
    source_address_prefix                      = "10.10.76.0/23"
    destination_address_prefix                 = null
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
    destination_address_prefix = "10.112.53.0/24"
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
