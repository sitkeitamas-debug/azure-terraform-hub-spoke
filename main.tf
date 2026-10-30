resource "azurerm_resource_group" "hub" {
  name     = "rg-hub-network-prod"
  location = "North Europe"
}

resource "azurerm_resource_group" "spoke" {
  name     = "rg-spoke-workload-prod"
  location = "North Europe"
}

# Hub Virtuális Hálózat
resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-prod"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Environment = "Production"
    Architecture = "Hub-Spoke"
  }
}

# Azure Firewall alhálózat
resource "azurerm_subnet" "hub_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.1.0/24"]
}

# VPN / Gateway alhálózat
resource "azurerm_subnet" "hub_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Menedzsment / Bastion alhálózat
resource "azurerm_subnet" "hub_mgmt" {
  name                 = "snet-management"
  resource_group_name  = azurerm_resource_group.hub.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.0.3.0/24"]
}

# Spoke Virtuális Hálózat
resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-workload-prod"
  location            = azurerm_resource_group.spoke.location
  resource_group_name = azurerm_resource_group.spoke.name
  address_space       = ["10.1.0.0/16"]

  tags = {
    Environment = "Production"
    Architecture = "Hub-Spoke"
  }
}

# Spoke Alkalmazási alhálózat
resource "azurerm_subnet" "spoke_workload" {
  name                 = "snet-workload"
  resource_group_name  = azurerm_resource_group.spoke.name
  virtual_network_name = azurerm_virtual_network.spoke.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Hub -> Spoke Peering
resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                      = "peer-hub-to-spoke"
  resource_group_name       = azurerm_resource_group.hub.name
  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}

# Spoke -> Hub Peering
resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                      = "peer-spoke-to-hub"
  resource_group_name       = azurerm_resource_group.spoke.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = false # True lesz, ha gateway-t is használunk a hubban
}