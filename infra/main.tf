terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "bootcampBenchmarkTerraform"
    storage_account_name = "bbtfstorage"
    container_name       = "bbtfcontainer"
    # key is the name of the file in the blob container
    key = "terraform.tfstate"
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "ukwest"
}

resource "azurerm_application_insights" "fa_insights" {
  name                = var.fa_insights_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_service_plan" "service_plan" {
  name                = var.fa_server_farm_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "Y1"


}

data "azurerm_client_config" "current" {}
