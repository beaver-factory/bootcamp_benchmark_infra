resource "azurerm_postgresql_server" "postgres_server" {
  name                          = var.postgres_server_name
  location                      = "uksouth"
  resource_group_name           = azurerm_resource_group.rg.name
  sku_name                      = "B_Gen5_1"
  administrator_login           = var.admin_login
  administrator_login_password  = var.admin_password
  version                       = "11"
  create_mode                   = "Default"
  public_network_access_enabled = true
  ssl_enforcement_enabled       = false

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
}

resource "azurerm_postgresql_database" "postgres_db" {
  name                = var.postgres_db_name
  server_name         = azurerm_postgresql_server.postgres_server.name
  resource_group_name = azurerm_resource_group.rg.name
  depends_on          = [azurerm_postgresql_server.postgres_server]
  collation           = "en_US.UTF8"
  charset             = "UTF8"
}

resource "azurerm_postgresql_firewall_rule" "postgres_firewall" {
  name                = "azureconnections"
  server_name         = azurerm_postgresql_server.postgres_server.name
  resource_group_name = azurerm_resource_group.rg.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
  depends_on          = [azurerm_postgresql_server.postgres_server]
}
