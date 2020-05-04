output "bastion_password" {
    value = random_password.bastion_password.result
}

output "vpn_cert_public_pem" {
    value = join("\n",slice(split("\n", tls_self_signed_cert.vpn.cert_pem), 1, length(split("\n",tls_self_signed_cert.vpn.cert_pem))-2))
}

output "vpn_cert_private_pem" {
    value = tls_private_key.vpn.private_key_pem
}