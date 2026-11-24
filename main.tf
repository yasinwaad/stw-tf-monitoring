resource "azurerm_monitor_data_collection_rule" "this" {
  name                = local.dcr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.common_tags

  destinations {
    storage_blob {
      name               = local.destination_name
      storage_account_id = var.storage_account_id
      container_name     = var.container_name
    }
  }

  data_sources {
    syslog {
      name           = local.syslog_source_name
      streams        = ["Microsoft-Syslog"]
      facility_names = var.syslog_facility_names
      log_levels     = var.syslog_log_levels
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = [local.destination_name]
  }
}

resource "azurerm_monitor_data_collection_rule_association" "this" {
  for_each = var.virtual_machine_ids

  name                    = local.association_names[each.key]
  target_resource_id      = each.value
  data_collection_rule_id = azurerm_monitor_data_collection_rule.this.id
}

resource "azurerm_virtual_machine_extension" "this" {
  for_each = var.virtual_machine_ids

  name                       = local.extension_names[each.key]
  virtual_machine_id         = each.value
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = var.agent_version
  auto_upgrade_minor_version = true
  automatic_upgrade_enabled  = true
  tags                       = local.common_tags
}