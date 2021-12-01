provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "basic" {
  name     = "basic-infrastructure"
  location = var.location
}
