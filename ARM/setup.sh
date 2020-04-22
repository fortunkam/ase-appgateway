PREFIX=mfase5
RG=$(echo $PREFIX)-rg
LOC=uksouth
VNET=$(echo $PREFIX)-vnet
ASESUBNET=ase
ASE=$(echo $PREFIX)-ase

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

SUBNET_ID=$(az network vnet subnet show -g $RG -n $ASESUBNET --vnet-name $VNET --query id -o tsv)

az group deployment create -g $RG --template-file "ase.json" --parameters name=$ASE location=$LOC zone=2 subnetId=$SUBNET_ID --no-wait
