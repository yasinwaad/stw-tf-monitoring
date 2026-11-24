variable "project_name" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "Environment name, e.g. prod."
  type        = string
}

variable "owner" {
  description = "Owner tag value."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "southafricanorth"

  validation {
    condition     = var.location == "southafricanorth"
    error_message = "Location must be southafricanorth."
  }
}

variable "resource_group_name" {
  description = "Name of the existing resource group."
  type        = string
}

variable "storage_account_id" {
  description = "ID of the storage account that receives the Syslog data."
  type        = string
}

variable "container_name" {
  description = "Name of the storage container that receives the Syslog data."
  type        = string
  default     = "syslog"
}

variable "virtual_machine_ids" {
  description = "Map of VM IDs, keyed by VM key. Use the vm_ids output of the VM module."
  type        = map(string)
}

variable "syslog_facility_names" {
  description = "Syslog facilities to collect."
  type        = list(string)
  default     = ["auth", "authpriv", "daemon", "syslog"]
}

variable "syslog_log_levels" {
  description = "Syslog log levels to collect."
  type        = list(string)
  default     = ["Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"]
}

variable "agent_version" {
  description = "Type handler version of the Azure Monitor Agent extension."
  type        = string
  default     = "1.0"
}