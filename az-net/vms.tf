# Create network interface
resource "azurerm_network_interface" "ubuntu-vm-nic" {
    name                      = "ubuntu-vm-NIC"
    location                  = azurerm_resource_group.decode_rg.location
    resource_group_name       = azurerm_resource_group.decode_rg.name

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
  algorithm     = "RSA"
  rsa_bits      = 4096
}
output "tls_private_key" { 
    value       = tls_private_key.decode_ssh.private_key_pem 
    sensitive   = false
}

resource "azurerm_public_ip" "decode_bastion_pip"{
    name                = "decode_bastion_pip"
    location            = azurerm_resource_group.decode_rg.location
    resource_group_name = azurerm_resource_group.decode_rg.name
    allocation_method   = "Static"
    sku                 = "Standard"
}

resource "azurerm_bastion_host" "decode_bastion_vm"{
    name                = "decode_bastion_vm"
    location            = azurerm_resource_group.decode_rg.location
    resource_group_name = azurerm_resource_group.decode_rg.name

    ip_configuration {
        name            = "bastion_config"
        subnet_id       = azurerm_subnet.decode_subnet_bastion.id
        puplic_ip_address_id = azurerm_pupblic_ip.decode_bastion_pip.id
    }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "ubuntu-vm" {
    name                  = "ubuntu-vm"
    location              = azurerm_resource_group.decode_rg.location
    resource_group_name   = azurerm_resource_group.decode_rg.name
    network_interface_ids = [azurerm_network_interface.ubuntu-vm-nic.id]
    size                  = "Standard_B1s"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "ubuntu-vm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = tls_private_key.decode_ssh.public_key_openssh
    }

    tags = {
        environment = "Terraform Demo"
      }
}
