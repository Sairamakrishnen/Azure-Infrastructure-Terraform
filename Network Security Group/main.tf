# Network Security Group (NSG)
resource "azurerm_network_security_group" "security_group" {
  name                = "security-group"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name

  security_rule {
    name                       = "allow_rdp"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }

  security_rule {
    name                       = "allow_http_https"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80-443"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.1.0/24"
  }
security_rule {
    name                       = "deny_all_other_ports"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate NSG with the Subnet
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.sub_net1.id
  network_security_group_id = azurerm_network_security_group.security_group.id
}
