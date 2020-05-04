locals {
    # Resource group
    rg_hub_name = "${var.prefix}-hub-rg"
    rg_spoke_name = "${var.prefix}-spoke-rg"

    # VNet
    vnet_hub_name="${var.prefix}-hub-vnet"
    vnet_spoke_name="${var.prefix}-spoke-vnet"
    vnet_hub_iprange="10.0.0.0/16"
    vnet_spoke_iprange="10.1.0.0/16"

    #Subnets 
    gateway_subnet="GatewaySubnet"
    gateway_subnet_iprange="10.0.0.0/24"
    bastion_subnet="BastionVM"
    bastion_subnet_iprange="10.0.1.0/24"
    ase_subnet="ASE"
    ase_subnet_iprange="10.1.0.0/24"   
    appgateway_subnet="AppGateway"
    appgateway_subnet_iprange="10.1.1.0/24"   
    hub_to_spoke_vnet_peer="${var.prefix}-hub-spoke-peer"
    spoke_to_hub_vnet_peer="${var.prefix}-spoke-hub-peer"

    #Storage
    storage_deploy="${var.prefix}deploy"
    storage_deploy_container_name="scripts"

    #VM
    bastion_publicip="${var.prefix}-bastion-ip"
    bastion_vm="${var.prefix}-bs-vm"
    bastion_disk="${var.prefix}-bastion-disk"
    bastion_nsg="${var.prefix}-bastion-nsg"
    bastion_internal_ipconfig="${var.prefix}-bastion-in-config"
    bastion_internal_nic="${var.prefix}-bastion-in-nic"
    bastion_external_nic="${var.prefix}-bastion-ext-nic"
    bastion_external_ipconfig="${var.prefix}-bastion-ext-config"  
    bastion_username="AzureAdmin"
    bastion_server_private_ip="10.0.1.128"  

    #ASE
    ase_name="${var.prefix}-ase"

    #AppPlan
    appplan_name="${var.prefix}-appplan"

    #VPN
    vpn_publicip="${var.prefix}-vpn-ip"
    vpn_name="${var.prefix}-vpn"
    vpn_address_space="10.2.0.0/24"
    vpn_root_cert_name="${var.prefix}-vpn-root-cert"

    #VPN Cert
    cert_common_name="${var.prefix}VPNCert"
    cert_organization="${var.prefix} Org"

    #DNS Zone
    ase_dns_zone="${local.ase_name}.appserviceenvironment.net"
    ase_scm_dns_zone="${local.ase_name}.scm.appserviceenvironment.net"
    ase_dns_link_hub="${var.prefix}-dns-vnet-hub"
    ase_dns_link_spoke="${var.prefix}-dns-vnet-spoke"

    #Website
    website_name="${var.prefix}-site"

    #App Gateway
    appgateway_publicip="${var.prefix}-appgateway-ip"
    appgateway="${var.prefix}-appgateway"
    appgateway_probe="${var.prefix}-appgateway-probe"
    appgateway_private_ip_address="10.1.1.5"
    appgateway_frontend_ip_configuration_name="${var.prefix}-appgateway-fe-ip"
    appgateway_frontend_port_name="${var.prefix}-appgateway-fe-port"
    appgateway_listener_name="${var.prefix}-appgateway-listener"
    appgateway_http_setting_name="${var.prefix}-appgateway-http-setting"
    appgateway_backend_pool_name="${var.prefix}-appgateway-backend-pool"
    appgateway_ipconfig_name="${var.prefix}-appgateway-ipconfig"
    appgateway_request_routing_rule_name="${var.prefix}-appgateway-rule"
}