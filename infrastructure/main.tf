locals {
  env = var.env
  riot_api_key = var.riot_api_key
}

provider "azurerm" {
  features {}
}


terraform {
  backend "azurerm" {
    resource_group_name  = "dev-lol-scout-rg"
    storage_account_name = "devlolscoutsa01"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }
}

module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = var.resource_group_name
  location = var.location
}

# resource "azurerm_resource_group" "lol_scout_rg" {
#   name     = "${local.env}-lol-scout-rg"
#   location = "eastus"
# }

module "service_plan" {
  source = "./modules/service_plan"

  resource_group_name = var.resource_group_name
  service_plan_name = var.service_plan_name
  location = var.location
}

# resource "azurerm_app_service_plan" "app_sp" {
#   name                = "${local.env}lolscoutsp01"
#   location            = azurerm_resource_group.lol_scout_rg.location
#   resource_group_name = azurerm_resource_group.lol_scout_rg.name

#   sku {
#     tier = "Free"
#     size = "F1"
#   }
# }

module "cosmos_db" {
  source = "./modules/cosmosdb"

  resource_group_name = var.resource_group_name
  db_name = var.db_name
  location = var.location
}

# resource "azurerm_cosmosdb_account" "app_db" {
#   name                = "${local.env}lolscoutdb01"
#   location            = azurerm_resource_group.lol_scout_rg.location
#   resource_group_name = azurerm_resource_group.lol_scout_rg.name
#   offer_type          = "Standard"

#   enable_automatic_failover = true
#   enable_free_tier          = true

#   consistency_policy {
#     consistency_level       = "BoundedStaleness"
#     max_interval_in_seconds = 300
#     max_staleness_prefix    = 100000
#   }

#   geo_location {
#     location          = azurerm_resource_group.lol_scout_rg.location
#     failover_priority = 1
#   }

#   geo_location {
#     location          = "westus"
#     failover_priority = 0
#   }
# }

module "windows_web_app" {
  source = "./modules/windows_web_app"

  resource_group_name = var.resource_group_name
  web_app_name = var.web_app_name
  location = var.location
  app_env_vars = var.app_env_vars
  service_plan_id = module.service_plan.output.service_plan_id
}

# resource "azurerm_windows_web_app" "app_wa" {
#   name                = "${local.env}lolscoutwa01"
#   resource_group_name = azurerm_resource_group.lol_scout_rg.name
#   location            = azurerm_app_service_plan.app_sp.location
#   service_plan_id     = azurerm_app_service_plan.app_sp.id

#   site_config {
#     always_on = false
#   }

#    app_settings = {
#     "RIOT_API_KEY" = local.riot_api_key
#   }
# }

