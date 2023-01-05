provider "azurerm" {
  features {}
}

data "terraform_remote_state" "state" {
  backend = "azurerm"
  config {
    resource_group_name  = "${var.env}-lol-scout-rg"
    storage_account_name = "${var.env}lolscoutsa01"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "dev-lol-scout-rg"
#     storage_account_name = "devlolscoutsa01"
#     container_name       = "terraform-state"
#     key                  = "terraform.tfstate"
#   }
# }

resource "azurerm_resource_group" "lol_scout_rg" {
  name     = "dev-lol-scout-rg"
  location = "eastus"
}

resource "azurerm_app_service_plan" "app_sp" {
  name                = "devlolscoutsp01"
  location            = azurerm_resource_group.lol_scout_rg.location
  resource_group_name = azurerm_resource_group.lol_scout_rg.name

  sku {
    tier = "Free"
    size = "F1"
  }
}
