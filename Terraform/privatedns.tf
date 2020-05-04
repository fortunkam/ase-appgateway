resource "azurerm_private_dns_zone" "ase" {
  name                = local.ase_dns_zone
  resource_group_name = azurerm_resource_group.spoke.name
  depends_on = [null_resource.getASEIP]
}

resource "azurerm_private_dns_zone" "ase_scm" {
  name                = local.ase_scm_dns_zone
  resource_group_name = azurerm_resource_group.spoke.name
  depends_on = [null_resource.getASEIP]
}

resource "azurerm_private_dns_zone_virtual_network_link" "hub" {
  name                  = local.ase_dns_link_hub
  resource_group_name   = azurerm_resource_group.spoke.name
  private_dns_zone_name = azurerm_private_dns_zone.ase.name
  virtual_network_id    = azurerm_virtual_network.hub.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "spoke" {
  name                  = local.ase_dns_link_spoke
  resource_group_name   = azurerm_resource_group.spoke.name
  private_dns_zone_name = azurerm_private_dns_zone.ase.name
  virtual_network_id    = azurerm_virtual_network.spoke.id
}

resource "azurerm_private_dns_a_record" "aseStar" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.ase.name
  resource_group_name = azurerm_resource_group.spoke.name
  ttl                 = 300
  records             = [ split("\r\n", data.local_file.ase_ip.content)[0] ]
}

resource "azurerm_private_dns_a_record" "aseAT" {
  name                = "@"
  zone_name           = azurerm_private_dns_zone.ase.name
  resource_group_name = azurerm_resource_group.spoke.name
  ttl                 = 300
  records             = [ split("\r\n", data.local_file.ase_ip.content)[0] ]
}

resource "azurerm_private_dns_a_record" "aseScmStar" {
  name                = "*"
  zone_name           = azurerm_private_dns_zone.ase_scm.name
  resource_group_name = azurerm_resource_group.spoke.name
  ttl                 = 300
  records             = [ split("\r\n", data.local_file.ase_ip.content)[0] ]
}

