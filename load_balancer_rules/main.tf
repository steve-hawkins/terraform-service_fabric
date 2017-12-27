variable "resource_group_name" {
  type        = "string"
  description = "Name of the resource group containing the load balancer"
}

variable "load_balancer_id" {
  type        = "string"
  description = "ID of the load balancer"
}

variable "backend_address_pool" {
  type        = "string"
  description = "Name of the backend address pool"
}

variable "load_balancer_rules" {
  type        = "list"
  description = <<-HEREDOC
  List of load balancer rules to apply
  Can include a minimum of name and port
  Optional:-
  probe_port will default to supplied port
  probe_protocol will default to Tcp if not supplied
  frontend_port will default to supplied port
  backend_port will default to supplied port
  protocol will default to Tcp is not supplied
  frontend will default to frontend if not supplied
  HEREDOC
}

resource "azurerm_lb_probe" "load_balancer_rule" {
  count               = "${length(var.load_balancer_rules)}"
  name                = "${lookup(var.load_balancer_rules[count.index], "name")}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${var.load_balancer_id}"
  port     = "${lookup(var.load_balancer_rules[count.index], "probe_port", lookup(var.load_balancer_rules[count.index], "port", ""))}"
  protocol = "${lookup(var.load_balancer_rules[count.index], "probe_protocol", lookup(var.load_balancer_rules[count.index], "protocol", "Tcp"))}"
}

resource "azurerm_lb_rule" "load_balancer_rule" {
  count               = "${length(var.load_balancer_rules)}"
  name                = "${lookup(var.load_balancer_rules[count.index], "name")}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${var.load_balancer_id}"
  protocol      = "${lookup(var.load_balancer_rules[count.index], "protocol", "Tcp")}"
  frontend_port = "${lookup(var.load_balancer_rules[count.index], "port", lookup(var.load_balancer_rules[count.index], "frontend_port", ""))}"
  backend_port  = "${lookup(var.load_balancer_rules[count.index], "port", lookup(var.load_balancer_rules[count.index], "backend_port", ""))}"
  frontend_ip_configuration_name = "${lookup(var.load_balancer_rules[count.index], "frontend", "frontend")}"
  backend_address_pool_id        = "${var.backend_address_pool}"
  probe_id                       = "${element(azurerm_lb_probe.load_balancer_rule.*.id, count.index)}"
  enable_floating_ip             = false
  load_distribution              = "SourceIPProtocol"
}
