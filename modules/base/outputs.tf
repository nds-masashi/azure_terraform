output "resource_group_location" {
  value = var.resource_group_location
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "my_subnet_id" {
  value = azurerm_subnet.my_subnet.id
}
