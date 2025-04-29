terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.27.0"
    }
  }
}

provider "azurerm" {
  features {}
  # subscription_id = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
}

provider "azurerm" {
  alias           = "aks-infra"
  subscription_id = var.aks_subscription_id
  features {}
}

provider "azurerm" {
  alias           = "mgmt"
  subscription_id = var.mgmt_subscription_id
  features {}
}

provider "azurerm" {
  alias = "cnp"
  features {}
  subscription_id = var.env == "nonprod" || var.env == "sandbox" ? "1c4f0704-a29e-403d-b719-b90c34ef14c9" : "8999dec3-0104-4a27-94ee-6588559729d1"
}

provider "azurerm" {
  alias = "soc"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8ae5b3b6-0b12-4888-b894-4cec33c92292" : var.env == "sbox" || var.env == "sandbox" ? "2307d175-7e49-434b-9ac2-515529b845f2" : "8ae5b3b6-0b12-4888-b894-4cec33c92292"
}

provider "azurerm" {
  alias = "dcr"
  features {}
  subscription_id = var.env == "prod" || var.env == "production" ? "8999dec3-0104-4a27-94ee-6588559729d1" : var.env == "sbox" || var.env == "sandbox" ? "bf308a5c-0624-4334-8ff8-8dca9fd43783" : "1c4f0704-a29e-403d-b719-b90c34ef14c9"
}
