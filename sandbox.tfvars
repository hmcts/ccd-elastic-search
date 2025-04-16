vms = {
  "ccd-data-0" = {
    name = "ccd-data-0"
    ip   = "10.100.157.10"
    managed_disks = 
    {
        disk1 = {
            name =       "ccd-data-0-datadisk1"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "0"
        }
        disk2 = {
            name = "ccd-data-0-datadisk2"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "1"
        }
    }

  }
  "ccd-data-1" = {
    name = "ccd-data-1"
    ip   = "10.100.157.11"
      managed_disks = 
    {
        disk1 = {
            name = "ccd-data-1-datadisk1"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "0"
        }
        disk2 = {
            name = "ccd-data-1-datadisk2"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "1"
        }
    }
  }
  "ccd-data-2" = {
    name = "ccd-data-2"
    ip   = "10.100.157.12"
     managed_disks = 
    {
        disk1 = {
            name = "ccd-data-2-datadisk1"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "0"
        }
        disk2 = {
            name = "ccd-data-2-datadisk2"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "1"
        }
    }
  }
  "ccd-data-3" = {
    name = "ccd-data-3"
    ip   = "10.100.157.13"
     managed_disks = 
    {
        disk1 = {
            name = "ccd-data-3-datadisk1"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "0"
        }
        disk2 = {
            name = "ccd-data-3-datadisk2"
            resource_group_name = "ccd-elastic-search-sandbox"
            disk_lun = "1"
        }
    }
  }
}

