data "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.subnet_name}"
  virtual_network_name = "${var.vnet_name}"
  resource_group_name  = "${var.vnet_rg_name}"
}