# Create a virtual network within the resource group
 resource "azurerm_virtual_network" "decode_vNet" {
   name                = "decode_network"
   resource_group_name = azurerm_resource_group.decode_rg.name
   location            = azurerm_resource_group.decode_rg.location
   address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "decode_subnet_pub" {
   name                 = "decode_pub_subnet"
   resource_group_name  = azurerm_resource_group.decode_rg.name
   virtual_network_name = azurerm_virtual_network.decode_vNet.name
   address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "decode_subnet_priv" {
  name                  = "decode_priv_subnet"
  resource_group_name   = azurerm_resource_group.decode_rg.name
  virtual_network_name  = azurerm_virtual_network.decode_vNet.name
  address_prefixes      = ["10.0.2.0/24"]
}
