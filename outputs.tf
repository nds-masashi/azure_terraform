output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# output "public_ip_address" {
#   value = module.vm_instance_1.public_ip_address
# }

output "admin_password" {
  sensitive = true
  value     = module.vm_instance_1.admin_password
}