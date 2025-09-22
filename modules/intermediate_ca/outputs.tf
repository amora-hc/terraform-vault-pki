output "intermediate_ca_certificate" {
  value = vault_pki_secret_backend_root_sign_intermediate.int_signed.certificate
}

output "intermediate_ca_issuer_id" {
  value = vault_pki_secret_backend_intermediate_set_signed.int_signed.id
}

output "path" {
  value = vault_mount.intermediate.path
}
