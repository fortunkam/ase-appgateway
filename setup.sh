PREFIX=mfase
RG=$(echo $PREFIX)-rg
LOC=uksouth
VNET=$(echo $PREFIX)-vnet
ASESUBNET=ase
APPGATEWAYSUBNET=appgateway
ASE=$(echo $PREFIX)-ase
APPPLAN=$(echo $PREFIX)-plan
SITE=$(echo $PREFIX)-web
STORAGE=$(echo $PREFIX)store
APPGATEWAY=$(echo $PREFIX)-gw
APPGATEWAYPUBLICIP=$(echo $PREFIX)-gw-ip
DNSSUFFIX=$prefix.com
AGFRONTENDPORT=$(echo $PREFIX)-gw-fe-port
AGPROBE=$(echo $PREFIX)-gw-probe
AGHTTPSETTINGS=$(echo $PREFIX)-gw-httpsettings
HOST=$SITE.$ASE.appserviceenvironment.net
AGPOOL=$(echo $PREFIX)-gw-fe-port
AGHTTPLISTENER=$(echo $PREFIX)-gw-httplistener
AGRULE=$(echo $PREFIX)-gw-rule


az group create -n $RG -l $LOC

az network vnet create \
    -g $RG \
    -n $VNET \
    --address-prefix 10.0.0.0/16

az network vnet subnet create \
    -g $RG \
    -n $ASESUBNET \
    --address-prefixes 10.0.0.0/24 \
    --vnet-name $VNET

az network vnet subnet create \
    -g $RG \
    -n $APPGATEWAYSUBNET \
    --address-prefixes 10.0.1.0/24 \
    --vnet-name $VNET



az appservice ase create -n $ASE -g $RG --vnet-name $VNET \
  --subnet $ASESUBNET --front-end-sku I1 \
  --virtual-ip-type Internal

az network public-ip create \
    -g $RG \
    -n $APPGATEWAYPUBLICIP

az network application-gateway create \
    -g $RG \
    -n $APPGATEWAY \
    --public-ip-address $APPGATEWAYPUBLICIP \
    --subnet $APPGATEWAYSUBNET \
    --vnet-name $VNET

az appservice plan create -g $RG -n $APPPLAN \
    --app-service-environment $ASE --sku I1

az webapp create \
    -n $SITE \
    -g $RG \
    --plan $APPPLAN \
    --runtime "node|10.15"

az webapp identity assign -g $RG -n $SITE

#https://docs.microsoft.com/en-us/azure/app-service/environment/integrate-with-application-gateway
#TODO: This Address is the Internal Load Balancer Address on the ASE (in theory az appservice ase list-addresses should get it but it is broken)
ASELBADDRESS=10.0.0.11
#TODO: This is a domain bound to App Gateway Public IP Address
HOSTNAME=ase-demo.memoryleek.co.uk


az network application-gateway address-pool create \
    -g $RG \
    -n $AGPOOL \
    --gateway $APPGATEWAY \
    --servers $ASELBADDRESS

az network application-gateway probe create -g $RG --gateway-name $APPGATEWAY \
    -n $AGPROBE --protocol http --host $HOSTNAME --path /

az network application-gateway http-settings create \
    --gateway-name $APPGATEWAY \
    --name $AGHTTPSETTINGS \
    --port 80 \
    --protocol Http \
    --resource-group $RG \
    --probe $AGPROBE

az network application-gateway frontend-port create \
    -g $RG \
    --gateway-name $APPGATEWAY \
    -n $AGFRONTENDPORT \
    --port 8080

az network application-gateway http-listener create \
    --frontend-port $AGFRONTENDPORT \
    -n $AGHTTPLISTENER \
    -g $RG \
    --gateway-name $APPGATEWAY

az network application-gateway rule create \
    -g $RG \
    --gateway-name $APPGATEWAY \
    -n $AGRULE \
    --address-pool $AGPOOL \
    --http-listener $AGHTTPLISTENER \
    --http-settings $AGHTTPSETTINGS

az webapp config hostname add --hostname $HOSTNAME --resource-group $RG --webapp-name $SITE



    