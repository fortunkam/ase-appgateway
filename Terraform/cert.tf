resource "tls_private_key" "vpn" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "vpn" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.vpn.private_key_pem

  subject {
    common_name  = local.cert_common_name
    organization = local.cert_organization
  }

  # Cert is valid for 30 days
  validity_period_hours = 720

  allowed_uses = [
    "client_auth",
  ]
}


# $cert = New-SelfSignedCertificate -Type Custom -KeySpec Signature `
# -Subject "CN=P2SVPNRootCert" -KeyExportPolicy Exportable `
# -HashAlgorithm sha256 -KeyLength 2048 `
# -CertStoreLocation "Cert:\CurrentUser\My" -KeyUsageProperty Sign -KeyUsage CertSign

# New-SelfSignedCertificate -Type Custom -DnsName P2SVPNClientCert -KeySpec Signature `
# -Subject "CN=P2SVPNClientCert" -KeyExportPolicy Exportable `
# -HashAlgorithm sha256 -KeyLength 2048 `
# -CertStoreLocation "Cert:\CurrentUser\My" `
# -Signer $cert -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.2")
