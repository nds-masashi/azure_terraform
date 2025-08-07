variable "ignore_ip" {}
variable "resource_group_location" {
  default = "japaneast"
}
variable "resource_group_name" {}
variable "my_subnet_id" {}

// Base
# module "base" {
#   source                  = "../../modules/base"
#   resource_group_location = var.resource_group_location
#   prefix                  = "work-vm"
# }

// SQL
module "sql" {
  source              = "../../modules/sql"
  prefix              = "work-sql"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name #module.base.resource_group_name
  subnet_id           = var.my_subnet_id        #module.base.my_subnet_id
}

// VM1 windows
module "vm1" {
  source              = "../../modules/vm_windows"
  prefix              = "work3-vm"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name #module.base.resource_group_name
  subnet_id           = var.my_subnet_id        #module.base.my_subnet_id
  public              = false
  ignore_ip           = var.ignore_ip
}

# module "vm2" {
#   source              = "../../modules/vm_windows"
#   prefix              = "work4-vm"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name #module.base.resource_group_name
#   subnet_id           = var.my_subnet_id        #module.base.my_subnet_id
#   public              = false
#   ignore_ip           = var.ignore_ip
# }

# VM2 linux
# module "vm2" {
#   source              = "../../modules/vm_linux"
#   prefix              = "work2-vm"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name #module.base.resource_group_name
#   subnet_id           = var.my_subnet_id        #module.base.my_subnet_id
#   public              = false
#   ignore_ip           = var.ignore_ip
# }
