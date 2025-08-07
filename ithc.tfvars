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
vms = {
  ccd-data-0 = {
    name = "ccd-data-0"
    ip   = "10.112.53.5"
    managed_disks = {
      disk1 = {
        name                = "ccd-data-0-datadisk1"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "0"
      }
      disk2 = {
        name                = "ccd-data-0-datadisk2"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "1"
      }
    }
  }
  ccd-data-1 = {
    name = "ccd-data-1"
    ip   = "10.112.53.9"
    managed_disks = {
      disk1 = {
        name                = "ccd-data-1-datadisk1"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "0"
      }
      disk2 = {
        name                = "ccd-data-1-datadisk2"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "1"
      }
    }
  }
  ccd-data-2 = {
    name = "ccd-data-2"
    ip   = "10.112.53.6"
    managed_disks = {
      disk1 = {
        name                = "ccd-data-2-datadisk1"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "0"
      }
      disk2 = {
        name                = "ccd-data-2-datadisk2"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "1"
      }
    }
  }
  ccd-data-3 = {
    name = "ccd-data-3"
    ip   = "10.112.53.7"
    managed_disks = {
      disk1 = {
        name                = "ccd-data-3-datadisk1"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "0"
      }
      disk2 = {
        name                = "ccd-data-3-datadisk2"
        resource_group_name = "ccd-elastic-search-ithc"
        disk_lun            = "1"
      }
    }
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
    description                                = "Allow Bastion access for debugging elastic queries on ITHC platform"
    priority                                   = 200
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "9200"
    source_address_prefix                      = "10.112.53.0/24"
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
    source_address_prefix                      = "10.112.0.0/16"
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
    source_address_prefix                      = "10.112.0.0/16"
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
    source_address_prefix                      = "10.112.0.0/16"
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
    source_address_prefix      = "10.112.53.0/24"
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
