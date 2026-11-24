provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-dev-southafricanorth"
  location = "southafricanorth"
}

resource "azurerm_virtual_network" "example" {
  name                = "vnet-example-dev-southafricanorth"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "example" {
  name                 = "snet-example-dev-southafricanorth"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

module "vm_nic" {
  source = "git::https://github.com/yasinwaad/stw-tf-vm-nic.git?ref=v1.0.0"

  project_name        = "example"
  environment         = "dev"
  owner               = "Yasin"
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id
  ssh_public_key      = file("~/.ssh/azure_vm_key.pub")

  vms = {
    linux = {}
  }
}

module "storage" {
  source = "git::https://github.com/yasinwaad/stw-tf-storage.git?ref=v1.0.0"

  project_name        = "example"
  environment         = "dev"
  owner               = "Yasin"
  resource_group_name = azurerm_resource_group.example.name

  storage_accounts = {
    syslog = {
      containers = ["syslog"]
    }
  }
}

module "monitoring" {
  source = "../.."

  project_name        = "example"
  environment         = "dev"
  owner               = "Yasin"
  resource_group_name = azurerm_resource_group.example.name
  storage_account_id  = module.storage.storage_account_ids["syslog"]
  virtual_machine_ids = module.vm_nic.vm_ids
}