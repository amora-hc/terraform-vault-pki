output "root_ca_certificate" {
  value = vault_pki_secret_backend_root_cert.root.certificate
}

output "root_ca_issuer_id" {
  value = vault_pki_secret_backend_root_cert.root.issuer_id
}

output "path" {
  value = vault_mount.root.path
}
