# Hub VNet adatai
output "hub_vnet_id" {
  description = "A Hub Virtuális Hálózat ID-ja"
  value       = azurerm_virtual_network.hub.id
}

output "hub_vnet_name" {
  description = "A Hub Virtuális Hálózat neve"
  value       = azurerm_virtual_network.hub.name
}

output "firewall_subnet_id" {
  description = "Az Azure Firewall alhálózat ID-ja"
  value       = azurerm_subnet.hub_firewall.id
}

# Spoke VNet adatai
output "spoke_vnet_id" {
  description = "A Spoke Virtuális Hálózat ID-ja"
  value       = azurerm_virtual_network.spoke.id
}

output "spoke_workload_subnet_id" {
  description = "A Spoke alkalmazási alhálózat ID-ja"
  value       = azurerm_subnet.spoke_workload.id
}

# Peering státuszok
output "hub_to_spoke_peering_id" {
  description = "A Hub -> Spoke Peering kapcsolat ID-ja"
  value       = azurerm_virtual_network_peering.hub_to_spoke.id
}

output "spoke_to_hub_peering_id" {
  description = "A Spoke -> Hub Peering kapcsolat ID-ja"
  value       = azurerm_virtual_network_peering.spoke_to_hub.id
}