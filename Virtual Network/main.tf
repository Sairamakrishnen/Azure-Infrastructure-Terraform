# Resource Group
resource "azurerm_resource_group" "res_grp" {
  name     = "res-grp"
  location = "East US"
}

# Virtual Network (VNet)
resource "azurerm_virtual_network" "v_net1" {
  name                = "v-net1"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  address_space       = ["10.0.0.0/16"]
}

# Subnet for VMSS and Load Balancer
resource "azurerm_subnet" "sub_net1" {
  name                 = "sub-net1"
  resource_group_name  = azurerm_resource_group.res_grp.name
  virtual_network_name = azurerm_virtual_network.v_net1.name
  address_prefixes     = ["10.0.1.0/24"]
}

