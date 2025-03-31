# Recovery Services Vault to store backups
resource "azurerm_recovery_services_vault" "rsv_1" {
  name                = "rsv-1"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  sku                  = "Standard"
}

# Backup Policy for the VMs

resource "azurerm_backup_policy_vm" "backup_policy" {
  name                = "backup-policy"
  resource_group_name = azurerm_resource_group.res_grp.name
  recovery_vault_name = azurerm_recovery_services_vault.rsv_1.name

  backup {
    frequency = "Daily"
    time      = "23:00"
  }
  retention_daily {
    count = 10
  }
}

# Backup the VM

resource "azurerm_backup_protected_vm" "backup_vm" {
  backup_vault_id = azurerm_recovery_services_vault.rsv_1.id
  resource_group_name = azurerm_resource_group.res_grp.name
  source_vm_id = azurerm_virtual_machine_scale_set.virtual_machines.id
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy.id
}
