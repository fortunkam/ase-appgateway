# Deploy an ASE with an App Gateway

Before running the Terraform scripts there is a powershell script that needs to be run first to generate and import the certificates needed for the Point-to-site VPN. `/Terraform/scripts/CreateVPNCert.ps1`

This repo has been tested using the following configuration
- Terraform v0.12.24
- Powershell Core v7 ("Classic" powershell won't work, I need a feature that was introduced in v6 !)

Once that is done, navigate to the Terraform folder in a powershell console.
Run `terraform init`
then `terraform apply`
to install everything.
WARNING: This script takes a while to deploy (~2 hours), the ASE,AppPlan and VPN Gateways make up the majority of this time!

What you are getting is..

- 2 peered vnets
- A VPN Gateway configured for a Point-to-site VPN
- An ILB ASE
- An App Gateway
- A VM (Bastion) for remote access (if the P2S VPN doesn't work)
- 2 private DNS zones for the ASE
- An App Plan and Website running on the ASE.

NOTE: although the terraform scripts deploy an app gateway, the routes need to be configured properly by assigned an internet facing domain name to the ASE and App Gateway. see here [https://docs.microsoft.com/en-us/azure/app-service/environment/integrate-with-application-gateway]() for more details

In order to use the Point-to-site VPN, Once the deploy is complete you will need to go to the azure portal to download the VPN client from the VPN gateway.  The required certificate should already be installed on your machine (CurrentUser store)