# Create network interface
resource "azurerm_network_interface" "ubuntu-vm-nic" {
    name                      = "ubuntu-vm-NIC"
    location                  = azurerm_resource_group.decode_rg.location
    resource_group_name       = azurerm_resource_group.myterraformgroup.name

    ip_configuration {
        name                          = "myNicConfiguration"
        subnet_id                     = azurerm_subnet.decode_subnet_priv.id
        private_ip_address_allocation = "Dynamic"
        # public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
    }

    tags = {
        environment = "decode"
    }
}

# Create (and display) an SSH key
resource "tls_private_key" "decode_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { 
    value = tls_private_key.example_ssh.private_key_pem 
    sensitive = true
}

# Create virtual machine
resource "azurerm_virtual_machine" "ubuntu-vm" {
  name                  = "ubuntu-vm"
  location              = azurerm_resource_group.decode_rg.location
  resource_group_name   = azurerm_resource_group.decode_rg.name
  network_interface_ids = [azurerm_network_interface.ubuntu-vm-nic.id]
  vm_size               = "Standard_B1s"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  
   computer_name  = "ubuntu-vm"
   admin_username = "azureuser"
   disable_password_authentication = truei

   admin_ssh_key {
      username   = "azureuser"
      public_key = tls_private_key.decode_ssh.public_key_openssh
   }
   
   tags = {
    environment = "decode"
  }
}
