# stw-tf-monitoring

Terraform module that generates an Azure Monitor Data Collection Rule to stream Syslog data to a storage account, associates it with Virtual Machines, and installs the Azure Monitor Agent on each VM.

## Usage

```hcl
module "monitoring" {
  source = "git::https://github.com/yasinwaad/stw-tf-monitoring.git?ref=v1.0.0"

  project_name        = "example"
  environment         = "dev"
  owner               = "Yasin"
  resource_group_name = "rg-example-dev-southafricanorth"
  storage_account_id  = module.storage.storage_account_ids["syslog"]
  virtual_machine_ids = module.vm_nic.vm_ids
}
```

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|
| project_name | Project name used in resource names | string | n/a |
| environment | Environment name, e.g. prod | string | n/a |
| owner | Owner tag value | string | n/a |
| resource_group_name | Name of the existing resource group | string | n/a |
| storage_account_id | ID of the storage account that receives the Syslog data | string | n/a |
| virtual_machine_ids | Map of VM IDs, keyed by VM key | map(string) | n/a |
| location | Azure region (only southafricanorth allowed) | string | southafricanorth |
| container_name | Storage container that receives the Syslog data | string | syslog |
| syslog_facility_names | Syslog facilities to collect | list(string) | ["auth", "authpriv", "daemon", "syslog"] |
| syslog_log_levels | Syslog log levels to collect | list(string) | ["Info", "Notice", "Warning", "Error", "Critical", "Alert", "Emergency"] |
| agent_version | Type handler version of the Azure Monitor Agent extension | string | 1.0 |

## Outputs

| Name | Description |
|------|-------------|
| dcr_id | ID of the Data Collection Rule |
| dcr_name | Name of the Data Collection Rule |
| association_ids | Map of association IDs, keyed by VM key |
| extension_ids | Map of Azure Monitor Agent extension IDs, keyed by VM key |

## Naming

Names are generated internally as `<resource>-<project_name>-<environment>-<location>`, with the VM key added for the associations and extensions.