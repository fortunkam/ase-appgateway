# Deploy an ASE with an App Gateway

Note: This will also contains scripts to deploy a P2S VPN (for connectivity on the vnet) however I haven't set up a Private DNS Zone so you will need host file hacks to connect.

Part of the setup for this requires a DNS entry to be configured for the app gateway (and as a custom host name in the App Service).  You will need to configure an A record to point at the App Gateway public IP.