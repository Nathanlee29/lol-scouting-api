variable "resource_group_name" {
    type = string
    description= "The name of the resource group."
}

variable "location" {
    type = string
    description = "The location the resources are associated with."
}

variable "db_name" {
    type = string
    description = "The name of the cosmosdb database"
}

variable "app_service_plan_name" {
    type = string
    description = "The name of the app service plan"
}

variable "web_app_name" {
    type = string
    description = "The name of the cosmosdb database"
}

variable "app_env_vars" {
    description = "The environment variables for the application."
}
