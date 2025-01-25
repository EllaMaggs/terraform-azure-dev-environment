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

resource "azurerm_network_security_group" "emtf-sg" {
  name                = "emtf-sg"
  location            = azurerm_resource_group.emtf-rg.location
  resource_group_name = azurerm_resource_group.emtf-rg.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "emtf-dev-rule" {
  name                        = "emtf-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "90.242.166.252/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.emtf-rg.name
  network_security_group_name = azurerm_network_security_group.emtf-sg.name
}

resource "azurerm_subnet_network_security_group_association" "emtf-sga" {
  subnet_id                 = azurerm_subnet.emtf-subnet.id
  network_security_group_id = azurerm_network_security_group.emtf-sg.id
}

resource "azurerm_public_ip" "emtf-ip" {
  name                = "emtf-ip"
  resource_group_name = azurerm_resource_group.emtf-rg.name
  location            = azurerm_resource_group.emtf-rg.location

  allocation_method = "Dynamic"
  sku               = "Basic"

  tags = {
    environment = "Dev"
  }
}

resource "azurerm_network_interface" "emtf-nic" {
  name                = "emtf-nic"
  location            = azurerm_resource_group.emtf-rg.location
  resource_group_name = azurerm_resource_group.emtf-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.emtf-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.emtf-ip.id
  }
  tags = {
    environment = "dev"
  }
}