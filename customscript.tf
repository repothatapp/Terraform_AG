# The storage account will be used to store the script for Custom Script extension

resource "azurerm_storage_account" "vmstore" {
  name                     = var.storage_account_name
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"  
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = var.storage_account_name
  container_access_type = "blob"
  depends_on=[
    azurerm_storage_account.vmstore
    ]
}

resource "azurerm_storage_blob" "IISConfig" {
  for_each = toset(local.function)
  name                   = "IIS_Config_${each.key}.ps1"
  storage_account_name   = var.storage_account_name
  storage_container_name = "data"
  type                   = "Block"
  source                 = "IIS_Config_${each.key}.ps1"
   depends_on=[azurerm_storage_container.data,
    azurerm_storage_account.vmstore]
}


resource "azurerm_virtual_machine_extension" "vmextension" {
  for_each = toset(local.function)
  name                 = "${each.key}-extension"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  depends_on = [
    azurerm_storage_blob.IISConfig
  ]
  settings = <<SETTINGS
    {
        "fileUris": ["https://${azurerm_storage_account.vmstore.name}.blob.core.windows.net/data/IIS_Config_${each.key}.ps1"],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config_${each.key}.ps1"     
    }
SETTINGS

}
