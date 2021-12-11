terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "resource" {
  name     = "appservice_docker"
  location = "westus"
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  kind = "Linux"
  reserved = true
  

  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "myapp" {
  name                = "dockerreactappservice222"
  location            = azurerm_resource_group.resource.location
  resource_group_name = azurerm_resource_group.resource.name
  app_service_plan_id = azurerm_app_service_plan.svcplan.id
  

  site_config {
    linux_fx_version = "DOCKER|bitroid/lessonslearnt:v1"
    # registry_source="Docker Hub"

  }
    
}

output "id" {
  value = azurerm_app_service_plan.svcplan.id
}
