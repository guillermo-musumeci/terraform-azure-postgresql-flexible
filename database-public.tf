#############################################
## PostgresSQL Public Database - Resources ##
#############################################

# Create PostgreSQL Public Flexible Server
resource "azurerm_postgresql_flexible_server" "public" {
  name                = "${lower(replace(var.company," ","-"))}-${var.app_name}-${var.environment}-postgresql-public"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  version  = var.postgres_server_version
  sku_name = var.postgres_server_sku
  
  public_network_access_enabled = true

  administrator_login    = var.postgres_user
  administrator_password = var.postgres_password
  
  zone = "1"

  storage_mb   = var.postgres_server_storage_mb
  storage_tier = var.postgres_server_storage_tier

  tags = var.tags
}

# Create PostgreSQL Database
resource "azurerm_postgresql_flexible_server_database" "public" {
  name      = "${var.app_name}-${var.environment}-db-public"
  server_id = azurerm_postgresql_flexible_server.public.id
  charset   = var.postgres_database_charset
  collation = var.postgres_database_collation

  # To  prevent the possibility of accidental data loss change to true in production
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [ azurerm_postgresql_flexible_server.public ]
}  

# Create PostgreSQL Firewall Rule for Azure Services
resource "azurerm_postgresql_flexible_server_firewall_rule" "azure" {
  name             = "azure_services"
  server_id        = azurerm_postgresql_flexible_server.public.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  depends_on = [ azurerm_postgresql_flexible_server.public ]
}

# Create PostgreSQL Firewall Rule for everyone
resource "azurerm_postgresql_flexible_server_firewall_rule" "everyone" {
  name             = "everyone"
  server_id        = azurerm_postgresql_flexible_server.public.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"

  depends_on = [ azurerm_postgresql_flexible_server.public ]
}

# Enable PostgreSQL Extensions
resource "azurerm_postgresql_flexible_server_configuration" "extensions" {
  name      = "azure.extensions"
  server_id = azurerm_postgresql_flexible_server.public.id
  value     = "VECTOR"
}

##########################################
## PostgresSQL Public Database - Output ##
##########################################

output "public_postgresql_server_name" {
  value       = azurerm_postgresql_flexible_server.public.name
  description = "The name of the PostgreSQL Server"
}

output "public_postgresql_database_name" {
  value       = azurerm_postgresql_flexible_server_database.public.name
  description = "The name of the PostgreSQL Database"
}
