# Create Network Security Group and rule
resource "azurerm_network_security_group" "decode_ubuntu_sg" {
    name                = "decode_ubuntu_sg"
    location            = azurerm_resource_group.decode_rg.location
    resource_group_name = azurerm_resource_group.decode_rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "Terraform Demo"
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "decode_nic_sg" {
    network_interface_id      = azurerm_network_interface.ubuntu-vm-nic.id
    network_security_group_id = azurerm_network_security_group.decode_ubuntu_sg.id
}
