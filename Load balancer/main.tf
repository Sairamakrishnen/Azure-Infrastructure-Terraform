#Load balancer public-ip
resource "azurerm_public_ip" "publicIPloadbalancer" {
  name                = "publicIPloadbalancer"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  allocation_method   = "Static"
}
#Load balancer
resource "azurerm_lb" "load_balancer" {
  name                = "load-balancer"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name

  frontend_ip_configuration {
    name                 = "publicIPaddress"
    public_ip_address_id = azurerm_public_ip.publicIPloadbalancer.id
  }
}

#Load balancer backend pool

resource "azurerm_lb_backend_address_pool" "BackEndAddressPool" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "lb_natpool1" {
  resource_group_name            = azurerm_resource_group.res_grp.name
  name                           = "lb-natpool1"
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = "Tcp"
  frontend_port_start            = 3380
  frontend_port_end              = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = azurerm_lb.load_balancer.frontend_ip_configuration[0].name
}

resource "azurerm_lb_nat_pool" "lb_natpool2" {
  resource_group_name            = azurerm_resource_group.res_grp.name
  name                           = "lb-natpool2"
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = "Tcp"
  frontend_port_start            = 80
  frontend_port_end              = 89
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.load_balancer.frontend_ip_configuration[0].name
}

resource "azurerm_lb_probe" "health_probe" {
  loadbalancer_id = azurerm_lb.load_balancer.id
  name            = "health-probe"
  protocol        = "Http"
  request_path    = "/health"
  port            = 80
}

resource "azurerm_network_interface" "network_interface1" {
  name                = "network-interface1"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name

  ip_configuration {
    name                          = "configuration1"
    subnet_id                     = azurerm_subnet.sub_net1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_network_interface" "network_interface2" {
  name                = "network-interface2"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name

  ip_configuration {
    name                          = "configuration2"
    subnet_id                     = azurerm_subnet.sub_net1.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_backend1" {
  network_interface_id    = azurerm_network_interface.network_interface1.id
  ip_configuration_name   = "configuration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
}
resource "azurerm_network_interface_backend_address_pool_association" "nic_backend2" {
  network_interface_id    = azurerm_network_interface.network_interface2.id
  ip_configuration_name   = "configuration2"
  backend_address_pool_id = azurerm_lb_backend_address_pool.BackEndAddressPool.id
}
