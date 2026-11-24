output "dcr_id" {
  description = "ID of the Data Collection Rule."
  value       = azurerm_monitor_data_collection_rule.this.id
}

output "dcr_name" {
  description = "Name of the Data Collection Rule."
  value       = azurerm_monitor_data_collection_rule.this.name
}

output "association_ids" {
  description = "Map of Data Collection Rule association IDs, keyed by VM key."
  value       = { for key, assoc in azurerm_monitor_data_collection_rule_association.this : key => assoc.id }
}

output "extension_ids" {
  description = "Map of Azure Monitor Agent extension IDs, keyed by VM key."
  value       = { for key, ext in azurerm_virtual_machine_extension.this : key => ext.id }
}