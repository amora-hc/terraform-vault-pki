# Creates a role on an PKI Intermediate CA Backend
resource "vault_pki_secret_backend_role" "role" {
  backend           = var.pki_mount_path
  name              = var.role_name
  allowed_domains   = var.allowed_domains
  allow_subdomains  = true
  max_ttl           = var.ttl
  allow_localhost   = false
  enforce_hostnames = true
  key_type          = var.key_type
  key_bits          = var.key_bits
  key_usage = var.key_usage
  ext_key_usage = var.ext_key_usage
  allow_any_name    = var.allow_any_name
}

# Issuing certificate endpoints, CRL distribution points, and OCSP server endpoints
resource "vault_pki_secret_backend_config_urls" "urls" {
  count                    = length(var.issuing_certificates) > 0 || length(var.crl_distribution_points) > 0 ? 1 : 0
  backend                  = var.pki_mount_path
  issuing_certificates     = var.issuing_certificates
  crl_distribution_points  = var.crl_distribution_points
}

# Generates a certificate from the PKI Intermediate CA Backend
resource "vault_pki_secret_backend_cert" "test_cert" {
  count      = var.issue_cert ? 1 : 0
  backend    = var.pki_mount_path
  name       = var.role_name
  common_name = var.common_name
  ttl         = var.ttl

  depends_on  = [vault_pki_secret_backend_role.role]
}  
