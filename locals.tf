locals {
  dcr_name           = "dcr-${var.project_name}-${var.environment}-${var.location}"
  destination_name   = substr("dest-${var.project_name}-${var.environment}-${var.location}", 0, 32)
  syslog_source_name = substr("syslog-${var.project_name}-${var.environment}-${var.location}", 0, 32)

  association_names = {
    for key, vm_id in var.virtual_machine_ids :
    key => "dcra-${key}-${var.project_name}-${var.environment}-${var.location}"
  }

  extension_names = {
    for key, vm_id in var.virtual_machine_ids :
    key => "ama-${key}-${var.project_name}-${var.environment}-${var.location}"
  }

  common_tags = {
    project = var.project_name
    owner   = var.owner
  }
}