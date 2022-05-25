resource   "azurerm_virtual_network"   "smart-farming-network"   { 
   name   =   "smart-farming-IoT-network" 
   address_space   =   [ "10.0.0.0/16" ] 
   location   =   var.resource_group_location
   resource_group_name   =   azurerm_resource_group.rg.name 
 } 

 resource   "azurerm_subnet"   "smart-farming-subnet"   { 
   name   =   "smart-farming-IoT-subnet" 
   resource_group_name   =    azurerm_resource_group.rg.name 
   virtual_network_name   =   azurerm_virtual_network.smart-farming-network.name 
   address_prefixes   =   ["10.0.1.0/24"]
 }

 resource   "azurerm_public_ip"   "smart-farming-public-ip"   { 
   name   =   "smart-farming-public-ip" 
   location   =   var.resource_group_location
   resource_group_name   =   azurerm_resource_group.rg.name 
   allocation_method   =   "Dynamic" 
 }

resource   "azurerm_network_interface"   "smart-farming-nw-interface"   { 
   name   =   "smart-farming-nw-interface" 
   location   =   var.resource_group_location 
   resource_group_name   =   azurerm_resource_group.rg.name 

   ip_configuration   { 
     name   =   "internal" 
     subnet_id   =   azurerm_subnet.smart-farming-subnet.id 
     private_ip_address_allocation   =   "Dynamic" 
     public_ip_address_id   =   azurerm_public_ip.smart-farming-public-ip.id 
   } 
 }

 resource "azurerm_network_security_group" "security_group" {
  name                = "smart_farming_security_group"
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "frontend_network" {
  name                       = "frontend_network"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.security_group.name
}
resource "azurerm_network_security_rule" "ssh_network" {
  name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.rg.name  
    network_security_group_name = azurerm_network_security_group.security_group.name
}

resource "azurerm_network_security_rule" "backend_network" {
  name                       = "backend_network"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.security_group.name
}

resource "azurerm_network_security_rule" "database_network" {
  name                       = "database_network"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.security_group.name
}