## PKI SECRETS ##

module "root" {
  source       = "./modules/root_ca"
  path         = "pki/root"
  common_name  = "customer.internal"
  ttl          = "350400h"
  key_bits     = 4096
  ou           = "PKI Root CA"
  organization = "Customer Lab"
}

module "subca-prod" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prod"
  common_name          = "prod.customer.internal"
  ttl                  = "175200h"
  key_bits             = 4096
  ou                   = "PKI Intermediate CA - Prod"
  organization         = "Customer Lab"
  root_mount_path      = module.root.path
  root_sign_common_name = "prod.customer.internal"

  depends_on = [module.root]
}

module "subca-prev" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prev"
  common_name          = "prev.customer.internal"
  ttl                  = "175200h"
  key_bits             = 4096
  ou                   = "PKI Intermediate CA - Prev"
  organization         = "Customer Lab"
  root_mount_path      = module.root.path
  root_sign_common_name = "prev.customer.internal"

  depends_on = [module.root]
}

module "subca-sand" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-sand"
  common_name          = "sand.customer.internal"
  ttl                  = "175200h"
  key_bits             = 4096
  ou                   = "PKI Intermediate CA - Sand"
  organization         = "Customer Lab"
  root_mount_path      = module.root.path
  root_sign_common_name = "sand.customer.internal"

  depends_on = [module.root]
}

module "subca-prod-azure" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prod-azure"
  common_name          = "azure.prod.customer.internal"
  ttl                  = "87600h"
  key_bits             = 4096
  ou                   = "PKI Cloud - Azure Prod"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prod.path
  root_sign_common_name = "azure.prod.customer.internal"

  depends_on = [module.subca-prod]
}

module "subca-prod-oci" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prod-oci"
  common_name          = "oci.prod.customer.internal"
  ttl                  = "87600h"
  key_bits             = 4096
  ou                   = "PKI Cloud - OCI Prod"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prod.path
  root_sign_common_name = "oci.prod.customer.internal"

  depends_on = [module.subca-prod]
}

module "subca-prev-azure" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prev-azure"
  common_name          = "azure.prev.customer.internal"
  ttl                  = "87600h"
  key_bits             = 4096
  ou                   = "PKI Cloud - Azure Prev"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prev.path
  root_sign_common_name = "azure.prev.customer.internal"

  depends_on = [module.subca-prev]
}

module "subca-prev-oci" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prev-oci"
  common_name          = "oci.prev.customer.internal"
  ttl                  = "87600h"
  key_bits             = 4096
  ou                   = "PKI Cloud - OCI Prev"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prev.path
  root_sign_common_name = "oci.prev.customer.internal"

  depends_on = [module.subca-prev]
}

module "subca-sand-azure" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-sand-azure"
  common_name          = "azure.sand.customer.internal"
  ttl                  = "87600h"
  key_bits             = 4096
  ou                   = "PKI Cloud - Azure Sand"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-sand.path
  root_sign_common_name = "azure.sand.customer.internal"

  depends_on = [module.subca-sand]
}

module "subca-sand-oci" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-sand-oci"
  common_name          = "oci.sand.customer.internal"
  ttl                  = "87600h"
  key_bits             = 4096
  ou                   = "PKI Cloud - OCI Sand"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-sand.path
  root_sign_common_name = "oci.sand.customer.internal"

  depends_on = [module.subca-sand]
}

## ROLES ##

module "subca-sand-azure-sign-doc" {
  source              = "./modules/pki_role"
  pki_mount_path      = module.subca-sand-azure.path
  role_name           = "subca-sand-azure-sign-doc"
  allowed_domains     = ["azure.sand.customer.internal"]
  key_type            = "rsa"
  key_bits            = 4096
  key_usage           = ["digitalSignature"]
  ext_key_usage       = []
  allow_any_name      = false
  issuing_certificates = ["https://vault.customer.internal/v1/pki/subca-sand-azure/ca"]
  crl_distribution_points = ["https://vault.customer.internal/v1/pki/subca-sand-azure/crl"]
  issue_cert          = false

  depends_on = [module.subca-sand-azure]
}

module "subca-sand-azure-ssl-public" {
  source              = "./modules/pki_role"
  pki_mount_path      = module.subca-sand-azure.path
  role_name           = "subca-sand-azure-ssl-public"
  allowed_domains     = ["azure.sand.customer.internal"]
  key_type            = "rsa"
  key_bits            = 2048
  key_usage           = ["serverAuth"]
  ext_key_usage       = []
  allow_any_name      = false
  issuing_certificates = ["https://vault.customer.internal/v1/pki/subca-sand-azure/ca"]
  crl_distribution_points = ["https://vault.customer.internal/v1/pki/subca-sand-azure/crl"]
  issue_cert          = false

  depends_on = [module.subca-sand-azure]
}

// module "subca-sand-azure-client-auth"
// module "subca-sand-azure-balancer-cert"
// module "subca-sand-azure-code-sign"
// module "subca-sand-azure-server-auth"
// module "subca-sand-azure-vpn-cert"
// module "subca-sand-azure-mdm-cert"
// module "subca-prev-azure-sign-doc"
// module "subca-prev-azure-sign-ssl-public"
// module "subca-prev-azure-client-auth"
// module "subca-prev-azure-balancer-cert"
// module "subca-prev-azure-code-sign"
// module "subca-prev-azure-server-auth"
// module "subca-prev-azure-vpn-cert"
// module "subca-prev-azure-mdm-cert"
// module "subca-prod-azure-sign-doc"
// module "subca-prod-azure-sign-ssl-public"
// module "subca-prod-azure-client-auth"
// module "subca-prod-azure-balancer-cert"
// module "subca-prod-azure-code-sign"
// module "subca-prod-azure-server-auth"
// module "subca-prod-azure-vpn-cert"
// module "subca-prod-azure-mdm-cert"
