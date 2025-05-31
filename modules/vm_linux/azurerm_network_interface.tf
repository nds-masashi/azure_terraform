# Create public IPs
resource "azurerm_public_ip" "my_public_ip" {
  count               = var.public ? 1 : 0
  name                = "${var.prefix}-jp-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "my_nic" {
  name                = "${var.prefix}-jp-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public ? azurerm_public_ip.my_public_ip[0].id : null
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "my_security" {
  network_interface_id      = azurerm_network_interface.my_nic.id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}
