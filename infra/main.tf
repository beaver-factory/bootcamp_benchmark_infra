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