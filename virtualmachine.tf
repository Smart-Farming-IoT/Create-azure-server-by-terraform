resource "azurerm_linux_virtual_machine" "smart-farming" {
  name                = "smart-farming"
  location            = var.resource_group_location 
  resource_group_name = azurerm_resource_group.rg.name 
  size              = "Standard_B1ms"
  admin_username      = "smartfarming"
  network_interface_ids   =   [ azurerm_network_interface.smart-farming-nw-interface.id ] 
  
  admin_ssh_key {
    username   = "smartfarming"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}