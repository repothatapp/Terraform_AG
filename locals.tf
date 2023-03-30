locals {
  resource_group_name= var.resource_group_name
  location=var.resource_group_location
  virtual_network = {
    name=var.vnet_name
    address_space=var.vnet_address_space
}

function=["videos","images"]
}
