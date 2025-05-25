variable "ignore_ip" {}
variable "resource_group_location"{
  default = "japaneast"
}
variable "resource_group_name"{}
variable "my_subnet_id"{}

// Base
# module "base" {
#   source                  = "../../modules/base"
#   resource_group_location = var.resource_group_location
#   prefix                  = "work-vm"
# }

# VM1
module "vm1" {
  source              = "../../modules/vm"
  prefix              = "work21-vm"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name #module.base.resource_group_name
  subnet_id           = var.my_subnet_id #module.base.my_subnet_id
  public              = false
  ignore_ip           = var.ignore_ip
}

# VM2
# module "vm2" {
#   source              = "../../modules/vm"
#   prefix              = "work22-vm"
#   location            = var.resource_group_location
#   resource_group_name = module.base.resource_group_name
#   subnet_id           = module.base.my_subnet_id
#   public              = true
#   ignore_ip           = var.ignore_ip
# }
