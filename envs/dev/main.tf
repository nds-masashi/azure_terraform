variable "ignore_ip" {}

// Base
module "base" {
  source                  = "../../modules/base"
  resource_group_location = "japaneast"
  prefix                  = "win-vm"
}

# VM1
module "vm1" {
  source              = "../../modules/vm"
  prefix              = "vm01"
  location            = module.base.resource_group_location
  resource_group_name = module.base.resource_group_name
  subnet_id           = module.base.my_subnet_id
  public              = true
  ignore_ip           = var.ignore_ip
}

# VM2
# module "vm2" {
#   source              = "../../modules/vm"
#   prefix              = "vm02"
#   location            = module.base.resource_group_location
#   resource_group_name = module.base.resource_group_name
#   subnet_id           = module.base.my_subnet_id
#   ignore_ip           = var.ignore_ip
# }
