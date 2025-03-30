# Virtual Machine Scale set
resource "azurerm_windows_virtual_machine_scale_set" "virtual_machines" {
  name                 = "virtual-machines"
  resource_group_name  = azurerm_resource_group.res_grp.name
  location             = azurerm_resource_group.res_grp.location
  sku                  = "Standard_F2"
  instances            = 2
  admin_password       = "P@55w0rd1234!"
  admin_username       = "adminuser"
  computer_name_prefix = "vm-"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # Data Disks Configuration
      data_disk {
        lun                    = 0  # Logical Unit Number for the disk
        caching                = "ReadWrite"
        storage_account_type = "Standard_LRS"
        create_option          = "Empty"  # Can be "FromImage" if you want to use an image
        disk_size_gb           = 50  # Size of the data disk in GB
      }
data_disk {
        lun                    = 1  # Another data disk with a different LUN
        caching                = "ReadWrite"
        create_option          = "Empty"
        storage_account_type = "Standard_LRS"
        disk_size_gb           = 50  # Size of the second data disk in GB
      
      }
network_interface {
    name    = "network_interface1"
    primary = true
  
    ip_configuration {
      name                                   = "IPConfiguration1"
      primary                                = true
      subnet_id                              = azurerm_subnet.sub_net1.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.BackEndAddressPool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lb_natpool1.id]
    }
  }
    network_interface {
    name    = "network_interface2"
    primary = false
  
    ip_configuration {
      name                                   = "IPConfiguration2"
      primary                                = true
      subnet_id                              = azurerm_subnet.sub_net1.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.BackEndAddressPool.id]
      load_balancer_inbound_nat_rules_ids    = [azurerm_lb_nat_pool.lb_natpool2.id]
    }
    }
     tags = {
  environment = "staging"
  }
  }
