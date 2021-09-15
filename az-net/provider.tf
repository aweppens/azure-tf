terraform {
     required_providers {
        azurerm = {
             source = "hashicorp/azurerm"
             version = "~>2.0"
         }
     }
}

provider "azurerm" {
     features {}
}

# Create a resource group
resource "azurerm_resource_group" "decode_rg" {
   name     = "decode-resources"
   location = "West Europe"
}
