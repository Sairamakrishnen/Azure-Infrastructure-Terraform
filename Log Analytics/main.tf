# Azure Monitor (Log Analytics Workspace)
resource "azurerm_log_analytics_workspace" "workspace_1" {
  name                = "workspace-1"
  location            = azurerm_resource_group.res_grp.location
  resource_group_name = azurerm_resource_group.res_grp.name
  sku                  = "PerGB2018"
  retention_in_days   = 30
}
