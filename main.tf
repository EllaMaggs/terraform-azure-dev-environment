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

resource "azurerm_resource_group" "emtf-rg" {
  name     = "emtf-resources"
  location = "West Europe"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "emtf-vn" {
  name                = "emtf-network"
  resource_group_name = azurerm_resource_group.emtf-rg.name
  location            = azurerm_resource_group.emtf-rg.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "emtf-subnet" {
  name                 = "emtf-subnet"
  resource_group_name  = azurerm_resource_group.emtf-rg.name
  virtual_network_name = azurerm_virtual_network.emtf-vn.name
  address_prefixes     = ["10.123.1.0/24"]
}