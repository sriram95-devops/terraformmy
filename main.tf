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
resource "azurerm_resource_group" "terrasmdshj" {
  name     = "example-resources"
  location = "eastus"
}

resource "azurerm_app_service_plan" "appplan" {
  name                = "example-appserviceplan"
  location            = azurerm_resource_group.terrasmdshj.location
  resource_group_name = azurerm_resource_group.terrasmdshj.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "webappmy" {
  name                = "example-app-service"
  location            = azurerm_resource_group.terrasmdshj.location
  resource_group_name = azurerm_resource_group.terrasmdshj.name
  app_service_plan_id = azurerm_app_service_plan.appplan.id

  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }
