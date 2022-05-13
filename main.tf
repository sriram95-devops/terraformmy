terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.5.0"
    }
  }
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "RG_today" {
  name     = "resources"
  location = "eastus"
}

resource "azurerm_app_service_plan" "appplan" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.RG_today.location
  resource_group_name = azurerm_resource_group.RG_today.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webappmy" {
  name                = "qwertyuiop"
  location            = azurerm_resource_group.RG_today.location
  resource_group_name = azurerm_resource_group.RG_today.name
  app_service_plan_id = azurerm_app_service_plan.appplan.id
}
