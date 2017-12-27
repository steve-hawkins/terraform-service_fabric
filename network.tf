resource "azurerm_virtual_network" "test" {
  name                = "${var.vnet_name}"
  address_space       = "${var.vnet_address_space}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
}

resource "azurerm_subnet" "test" {
  name                 = "${var.subnet_name}"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix       = "${var.subnet_address_prefix}"
}

resource "azurerm_public_ip" "test" {
  name                         = "${var.public_ip_name}"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.test.name}"
  public_ip_address_allocation = "${var.public_ip_address_allocation}"
  domain_name_label            = "${azurerm_resource_group.test.name}"
}
