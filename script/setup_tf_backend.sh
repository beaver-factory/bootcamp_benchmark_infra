#!/bin/bash
set -e 

read -p "Name your resource group for holding Terraform state: " rg_name
PS3="And where would you like it to be provisioned: " 
locations=("ukwest" "uksouth")
select opt in "${locations[@]}";
do
    case $opt in
        "uksouth")
            location=$opt
            break
            ;;
        "ukwest")
            location=$opt
            break
            ;;
    esac
done

az group create --name $rg_name --location $location

echo "✅ resource group successfully deployed"


read -p "Name your storage account for holding Terraform state: " sa_name

az storage account create --resource-group $rg_name \
--location $location --name $sa_name \
--sku Standard_LRS --kind StorageV2

echo "✅ storage account successfully deployed"

read -p "And name your blob container for holding Terraform state: " container_name

az storage container create --name $container_name --account-name $sa_name

echo "✅ storage container successfully deployed"

echo -e "terraform {
  required_providers {
    azurerm = {
      source  = \"hashicorp/azurerm\"
      version = \"~> 3.0.2\"
    }
  }
  backend \"azurerm\" {
    resource_group_name = \"$rg_name\"
    storage_account_name = \"$sa_name\"
    container_name = \"$container_name\"
    # key is the name of the file in the blob container
    key = \"terraform.tfstate\"
  }

  required_version = \">= 1.1.0\"
}

provider \"azurerm\" {
  features {}
}" > main.tf

terraform init

echo "✅ azure resources for terraform backend successfully deployed and main.tf created with relevant creds"