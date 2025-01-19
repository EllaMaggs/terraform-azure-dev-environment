terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "b5e7a8d2-4ced-4cf6-942e-9707cd426d93"
}

resource "azurerm_resource_group" "emtf-rm" {
  name     = "emtf-resources"
  location = "West Europe"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "emtf-vn" {
  name                = "emtf-network"
  resource_group_name = azurerm_resource_group.emtf-rm.name
  location            = azurerm_resource_group.emtf-rm.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}