variable name {}
variable location {}
variable resource_group_name {}
variable subnet_id {}
variable network_security_group_id {}

# Password
resource "random_password" "password" {
  length      = 20
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
  min_special = 1
  special     = true
}

# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = var.resource_group_name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "my_storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create public IPs
# resource "azurerm_public_ip" "my_public_ip" {
#   name                = "${var.name}-public-ip"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Dynamic"
# }

# Create network interface
resource "azurerm_network_interface" "my_nic" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = azurerm_public_ip.my_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example1" {
  network_interface_id      = azurerm_network_interface.my_nic.id
  network_security_group_id = var.network_security_group_id
}

# VM
resource "azurerm_windows_virtual_machine" "vm" {
  name                  = var.name
  admin_username        = "azureuser"
  admin_password        = random_password.password.result
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.my_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "${var.name}-myOsDisk"
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

#Install IIS web server to the virtual machine
# resource "azurerm_virtual_machine_extension" "web_server_install" {
#   name                       = "${var.name}-wsi"
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

output "admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.vm.admin_password
}

# output "public_ip_address" {
#   sensitive = true
#   value     = azurerm_public_ip.my_public_ip.ip_address
# }