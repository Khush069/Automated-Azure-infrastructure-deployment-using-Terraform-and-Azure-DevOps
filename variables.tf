variable "resource_group_name" {
  default = "rg-infra-demo"
}

variable "location" {
  default = "eastus"
}

variable "vnet_name" {
  default = "vnet-demo"
}

variable "subnet_name" {
  default = "subnet-demo"
}

variable "vm_name" {
  default = "vm-demo"
}

variable "vm_size" {
  default = "Standard_DC1ds_v3"
}

variable "vm_zone" {
  default = "2"
}

variable "admin_username" {
  default = "azureadmin"
}

variable "admin_password" {
  description = "Password for the VM admin user"
  type        = string
}
