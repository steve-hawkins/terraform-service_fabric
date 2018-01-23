resource "azurerm_resource_group" "test" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"

  tags = "${var.tags}"
}

resource "azurerm_virtual_machine_scale_set" "test" {
  name                = "${var.vm_scale_set_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  upgrade_policy_mode = "${var.vm_scale_set_upgrade}"

  sku {
    name     = "${var.vm_size}"
    tier     = "${var.vm_scale_set_tier}"
    capacity = "${var.vm_scale_set_capacity}"
  }

  storage_profile_image_reference {
    publisher = "${var.vm_image_publisher}"
    offer     = "${var.vm_image_offer}"
    sku       = "${var.vm_image_sku}"
    version   = "${var.vm_image_version}"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "${var.vm_os_disk_type}"
  }

  storage_profile_data_disk {
    lun               = 0
    caching           = "ReadWrite"
    create_option     = "Empty"
    disk_size_gb      = "${var.vm_data_disk_size}"
    managed_disk_type = "${var.vm_data_disk_type}"
  }

  os_profile {
    computer_name_prefix = "${var.vm_name_prefix}"
    admin_username       = "${var.vm_admin_username}"
    admin_password       = "${var.vm_admin_password}"
  }

  os_profile_secrets {
    source_vault_id = "${azurerm_key_vault.test.id}"
    vault_certificates {
      certificate_url   = "${azurerm_key_vault.test.vault_uri}/secrets/service-fabric-server/${azurerm_key_vault_certificate.service_fabric_server.version}"
      certificate_store = "${var.certificate_store_value}"
    }
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  network_profile {
    name    = "${var.vm_network_profile_name}"
    primary = true

    ip_configuration {
      name                                   = "${var.vm_network_profile_ip_name}"
      subnet_id                              = "${azurerm_subnet.test.id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.test.id}"]
      load_balancer_inbound_nat_rules_ids    = ["${azurerm_lb_nat_pool.test.id}"]
    }
  }

  # extension {
  #   name                       = "${var.service_fabric_name}"
  #   publisher                  = "${var.service_fabric_publisher}"
  #   type                       = "${var.service_fabric_type}"
  #   type_handler_version       = "${var.service_fabric_type_handler_version}"
  #   auto_upgrade_minor_version = "${var.service_fabric_auto_upgrade}"
  #   settings                   = "${var.service_fabric_settings}"
  #   protected_settings         = "${var.service_fabric_protected_settings}"
  # }

  tags = "${var.tags}"
}
