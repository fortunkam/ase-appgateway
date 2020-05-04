$PREFIX = "mfase"
$RG = "$PREFIX-rg"
$PUBLIC_IP = "$PREFIX-vpn-publicip"
$VNET = "$PREFIX-VNET"
$VPNGATEWAY = "$PREFIX-gateway"
$ROOTCERT = "$PREFIX-gateway-rootcert"

#create a public ip address for the P2S VPN gateway
#az network public-ip create --name $PUBLIC_IP --resource-group $RG --allocation-method Dynamic

# create the subnet with an nsg for the VPN gateway (Note the Subnet must be called GatewaySubnet)
#az network vnet subnet create --resource-group $RG --vnet-name $VNET --name "GatewaySubnet" --address-prefixes 10.0.2.0/24

#create the vnet gateway (takes ages)
az network vnet-gateway create --name $VPNGATEWAY --resource-group $RG --public-ip-addresses $PUBLIC_IP --vpn-type RouteBased --vnet $VNET --address-prefixes 172.16.201.0/24 --sku VpnGw1 --gateway-type Vpn --client-protocol IkeV2

$filePathForCert = ".\P2SVPNRootCert.cer"
$cert = new-object System.Security.Cryptography.X509Certificates.X509Certificate2($filePathForCert)
$CertBase64 = [system.convert]::ToBase64String($cert.RawData)

#add the root cert to the gateway
az network vnet-gateway root-cert create --resource-group $RG --name $ROOTCERT --gateway-name $VPNGATEWAY --public-cert-data $CertBase64
