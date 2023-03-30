# Azure Resource Group Name 
variable "resource_group_name" {
  description = "Resource Group Name"
  type = string
  default = "rg-default"  
}

# Azure Resources Location
variable "resource_group_location" {
  description = "Region in which Azure Resources to be created"
  type = string
  default = "eastus"  
}

# Azure Storage Account Name
variable "storage_account_name" {
  description = "Name of the Storage Account to store Custom Scripts"
  type = string
}

# Azure Virtual Network Name
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}

# Azure Virtual Network Address Space
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}

# Application Gateway Subnet Name
variable "ag_subnet_name" {
  description = "Virtual Network Application Gateway Subnet Name"
  type = string
  default = "agsubnet"
}
