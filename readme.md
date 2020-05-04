# Deploy an ASE with an App Gateway

Before running the Terraform scripts there is a powershell script that needs to be run first to generate and import the certificates needed for the Point-to-site VPN. `/Terraform/scripts/CreateVPNCert.ps1`

Once that is done, navigate to the Terraform folder in a powershell console.
Run `terraform init`
then `terraform apply`
to install everything.

What you are getting is..

- 2 peered vnets
- A VPN Gateway configured for a Point-to-site VPN
- An ILB ASE
- An App Gateway
- A VM (Bastion) for remote access (if the P2S VPN doesn't work)
- 2 private DNS zones for the ASE
- An App Plan and Website running on the ASE.