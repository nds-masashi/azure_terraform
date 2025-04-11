# Password
resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

# VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "${var.prefix}-jp-vm"
  admin_username        = "azureuser"
  admin_password        = random_password.password.result
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.my_nic.id]
  size                  = "Standard_DS3_v2" #"Standard_DS1_v2" $0.2 "Standard_DS3_v2" $0.5

  os_disk {
    name                 = "${var.prefix}-myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
}

# Custom powershell
# resource "azurerm_virtual_machine_extension" "custom" {
#   name                       = "${var.prefix}-wsi"
#   virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
#   publisher                  = "Microsoft.Compute"
#   type                       = "CustomScriptExtension"
#   type_handler_version       = "1.8"
#   auto_upgrade_minor_version = true

#   settings = <<SETTINGS
#     {
#       "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
#     }
#   SETTINGS
# }

# Auto shutdown
# resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm" {
#   virtual_machine_id = azurerm_windows_virtual_machine.vm.id
#   location           = var.resource_group_name
#   enabled            = true

#   daily_recurrence_time = "1900"
#   timezone              = "Tokyo Standard Time"

#   notification_settings {
#     enabled         = true
#     time_in_minutes = "60"
#     webhook_url     = "https://sample-webhook-url.example.com"
#   }
# }