output "key_data" {
  value = azapi_resource_action.ssh_public_key_gen.output.publicKey
}

output "public_ip_address" {
  sensitive = true
  value     = var.public ? azurerm_public_ip.my_public_ip[0].ip_address : ""
}