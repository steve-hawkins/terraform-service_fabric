resource "azurerm_lb" "test" {
  name                = "${var.load_balancer_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = "${azurerm_public_ip.test.id}"
  }
}

resource "azurerm_lb_backend_address_pool" "test" {
  resource_group_name = "${azurerm_resource_group.test.name}"
  loadbalancer_id     = "${azurerm_lb.test.id}"
  name                = "BackEndAddressPool"
}

resource "azurerm_lb_nat_pool" "test" {
  resource_group_name            = "${azurerm_resource_group.test.name}"
  loadbalancer_id                = "${azurerm_lb.test.id}"
  name                           = "LoadBalancerBEAddressNatPool"
  protocol                       = "Tcp"
  frontend_port_start            = 3389
  frontend_port_end              = 4500
  backend_port                   = 3389
  frontend_ip_configuration_name = "frontend"
}

variable "load_balancer_rules" {
  type    = "list"
  default = [
    {
      name = "fabric_tcp"
      port = 19000
    },
    {
      name = "fabric_http"
      port = 19080
    },
    {
      name = "app_http"
      port = 80
    },
    {
      name = "app_https"
      port = 443
    }
  ]
}

module "load_balancer_rules" {
  source               = "./load_balancer_rules"
  resource_group_name  = "${var.resource_group_name}"
  load_balancer_id     = "${azurerm_lb.test.id}"
  backend_address_pool = "${azurerm_lb_backend_address_pool.test.id}"
  load_balancer_rules  = "${var.load_balancer_rules}"
}
