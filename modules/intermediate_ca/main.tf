# Enables a new PKI secrets engine for Intermediate CA
resource "vault_mount" "intermediate" {
  path        = var.path
  type        = "pki"
  description = var.ou
  //options     = {
  //  max_lease_ttl = var.ttl
  //}
  default_lease_ttl_seconds = var.default_lease_ttl
  max_lease_ttl_seconds     = var.max_lease_ttl
}

# Generates a new private key and a CSR for signing the PKI secrets Root CA Backend
resource "vault_pki_secret_backend_intermediate_cert_request" "int" {
  backend      = vault_mount.intermediate.path
  type         = "internal"
  common_name  = var.common_name
  key_type     = "rsa"
  key_bits     = var.key_bits
  ou           = var.ou
  organization = var.organization
}

# Creates PKI certificate from CSR
resource "vault_pki_secret_backend_root_sign_intermediate" "int_signed" {
  backend     = var.root_mount_path
  csr         = vault_pki_secret_backend_intermediate_cert_request.int.csr
  common_name = var.root_sign_common_name
  ttl         = var.ttl
}

# Submits the CA certificate to the PKI Intermediate CA Backend
resource "vault_pki_secret_backend_intermediate_set_signed" "int_signed" {
  backend     = vault_mount.intermediate.path
  certificate = vault_pki_secret_backend_root_sign_intermediate.int_signed.certificate
}
