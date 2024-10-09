# Definición del provider de Azure
provider "azurerm" {
  features {}
  subscription_id = ""
}

# Grupo de recursos donde se asociarán los demás recursos.
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Red virtual
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subred dentro de la red virtual
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Llamada al módulo vm
module "vm" {
  source               = "./modules/vm"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  vm_size              = var.vm_size
  admin_username       = var.admin_username
  admin_password       = var.admin_password
  network_interface_id = azurerm_network_interface.nic.id
  vnet_name            = var.vnet_name      # Agregando variable vnet_name
  subnet_name          = var.subnet_name    # Agregando variable subnet_name
}
