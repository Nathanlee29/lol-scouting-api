locals {
    environment = "dev"
}

module "infra" {
  source = "../../"
  resource_group_name = "${local.environment}-lol-scout-rg"
  storage_account_name = "${local.environment}lolscoutsa01"
  service_plan_name = "${local.environment}lolscoutsp01"
  location = "eastus"
}
