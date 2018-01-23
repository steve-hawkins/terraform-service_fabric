data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "test" {
  name                = "${var.vault_name}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  sku {
    name = "standard"
  }

  tenant_id = "${data.azurerm_client_config.current.tenant_id}"

  access_policy {
    tenant_id = "${data.azurerm_client_config.current.tenant_id}"
    # object_id = "${data.azurerm_client_config.current.service_principal_object_id}"
    object_id = "${var.object_id}"

    certificate_permissions = [
      "create","delete","deleteissuers",
      "get","getissuers","import","list",
      "listissuers","managecontacts","manageissuers",
      "setissuers","update",
    ]

    key_permissions = [
      "backup","create","decrypt","delete","encrypt","get",
      "import","list","purge","recover","restore","sign",
      "unwrapKey","update","verify","wrapKey",
    ]

    secret_permissions = [
      "backup","delete","get","list","purge","recover","restore","set",
    ]
  }

  enabled_for_deployment = true

  tags = "${var.tags}"
}

resource "azurerm_key_vault_certificate" "service_fabric_server" {
  name      = "service-fabric-server"
  vault_uri = "${azurerm_key_vault.test.vault_uri}"

  certificate_policy {
    issuer_parameters {
      name = "Self"
    }

    key_properties {
      exportable = true
      key_size   = 2048
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      action {
        action_type = "AutoRenew"
      }

      trigger {
        days_before_expiry = 30
      }
    }

    secret_properties {
      content_type = "application/x-pkcs12"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = "CN=service-fabric-server"
      validity_in_months = 12
    }
  }
}

# resource "azurerm_key_vault_certificate" "service_fabric_cluster" {
#   name      = "service-fabric-cluster"
#   vault_uri = "${azurerm_key_vault.test.vault_uri}"

#   certificate_policy {
#     issuer_parameters {
#       name = "Self"
#     }

#     key_properties {
#       exportable = true
#       key_size   = 2048
#       key_type   = "RSA"
#       reuse_key  = true
#     }

#     lifetime_action {
#       action {
#         action_type = "AutoRenew"
#       }

#       trigger {
#         days_before_expiry = 30
#       }
#     }

#     secret_properties {
#       content_type = "application/x-pkcs12"
#     }

#     x509_certificate_properties {
#       key_usage = [
#         "cRLSign",
#         "dataEncipherment",
#         "digitalSignature",
#         "keyAgreement",
#         "keyCertSign",
#         "keyEncipherment",
#       ]

#       subject            = "CN=service-fabric-cluster"
#       validity_in_months = 12
#     }
#   }
# }

# resource "azurerm_key_vault_certificate" "service_fabric_application" {
#   name      = "service-fabric-application"
#   vault_uri = "${azurerm_key_vault.test.vault_uri}"

#   certificate_policy {
#     issuer_parameters {
#       name = "Self"
#     }

#     key_properties {
#       exportable = true
#       key_size   = 2048
#       key_type   = "RSA"
#       reuse_key  = true
#     }

#     lifetime_action {
#       action {
#         action_type = "AutoRenew"
#       }

#       trigger {
#         days_before_expiry = 30
#       }
#     }

#     secret_properties {
#       content_type = "application/x-pkcs12"
#     }

#     x509_certificate_properties {
#       key_usage = [
#         "cRLSign",
#         "dataEncipherment",
#         "digitalSignature",
#         "keyAgreement",
#         "keyCertSign",
#         "keyEncipherment",
#       ]

#       subject            = "CN=service-fabric-application"
#       validity_in_months = 12
#     }
#   }
# }
