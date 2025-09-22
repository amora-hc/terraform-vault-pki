# Enables a new PKI secrets engine for Root CA
resource "vault_mount" "root" {
  path        = var.path
  type        = "pki"
  description = var.ou
  default_lease_ttl_seconds = var.default_lease_ttl
  max_lease_ttl_seconds     = var.max_lease_ttl
}

# Generates a new self-signed CA certificate and private keys for the PKI secrets Root CA Backend
resource "vault_pki_secret_backend_root_cert" "root" {
  backend               = vault_mount.root.path
  type                  = "internal"
  common_name           = var.common_name
  ttl                   = var.ttl
  key_type              = "rsa"
  key_bits              = var.key_bits
  ou                    = var.ou
  organization          = var.organization
}
