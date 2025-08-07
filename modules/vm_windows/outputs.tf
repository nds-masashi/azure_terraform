// tfstate にパスワードが含まれるが、&は\u0026と表記されるので注意
output "admin_password" {
  sensitive = true
  value     = azurerm_windows_virtual_machine.vm.admin_password
}

output "public_ip_address" {
  sensitive = true
  value     = var.public ? azurerm_public_ip.my_public_ip[0].ip_address : ""
}