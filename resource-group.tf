resource "azurerm_resource_group" "rg" {
  name      = "smart-farming-IoT"
  location  = var.resource_group_location
}