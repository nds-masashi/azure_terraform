variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "public" {
    type = bool
    default = false
}
variable "ignore_ip" {}