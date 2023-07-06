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