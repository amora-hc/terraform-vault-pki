## PKI SECRETS ##

module "root" {
  source       = "./modules/root_ca"
  path         = "pki/root"
  common_name  = local.common_name
  #ttl          = "350400h" // 40 years
  ttl          = 1261440000 // 40 years
  //max_lease_ttl     = 630720000 // 20 years
  max_lease_ttl     = 1261440000 // 40 years
  default_lease_ttl = 31536000  // 1 year
  key_bits     = 4096
  ou           = "PKI Root CA"
  organization = "Customer Lab"
}

module "subca-prod" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prod"
  common_name          = "prod.${local.common_name}"
  ttl                  = 630720000 // 20 years
  max_lease_ttl        = 315360000 // 10 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Intermediate CA - Prod"
  organization         = "Customer Lab"
  root_mount_path      = module.root.path
  root_sign_common_name = "prod.${local.common_name}"

  depends_on = [module.root]
}

module "subca-prev" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prev"
  common_name          = "prev.${local.common_name}"
  ttl                  = 630720000 // 20 years
  max_lease_ttl        = 315360000 // 10 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Intermediate CA - Prev"
  organization         = "Customer Lab"
  root_mount_path      = module.root.path
  root_sign_common_name = "prev.${local.common_name}"

  depends_on = [module.root]
}

module "subca-sand" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-sand"
  common_name          = "sand.${local.common_name}"
  //ttl                  = "175200h" // 20 years
  ttl                  = 630720000 // 20 years
  max_lease_ttl        = 315360000 // 10 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Intermediate CA - Sand"
  organization         = "Customer Lab"
  root_mount_path      = module.root.path
  root_sign_common_name = "sand.${local.common_name}"

  depends_on = [module.root]
}

module "subca-prod-azure" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prod-azure"
  common_name          = "azure.prod.${local.common_name}"
  ttl                  = 315360000 // 10 years
  max_lease_ttl        = 157680000 // 5 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Cloud - Azure Prod"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prod.path
  root_sign_common_name = "azure.prod.${local.common_name}"

  depends_on = [module.subca-prod]
}

module "subca-prod-oci" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prod-oci"
  common_name          = "oci.prod.${local.common_name}"
  #ttl                  = "87600h" // 10 years
  ttl                  = 315360000 // 10 years
  max_lease_ttl        = 157680000 // 5 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Cloud - OCI Prod"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prod.path
  root_sign_common_name = "oci.prod.${local.common_name}"

  depends_on = [module.subca-prod]
}

module "subca-prev-azure" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prev-azure"
  common_name          = "azure.prev.${local.common_name}"
  ttl                  = 315360000 // 10 years
  max_lease_ttl        = 157680000 // 5 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Cloud - Azure Prev"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prev.path
  root_sign_common_name = "azure.prev.${local.common_name}"

  depends_on = [module.subca-prev]
}

module "subca-prev-oci" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-prev-oci"
  common_name          = "oci.prev.${local.common_name}"
  ttl                  = 315360000 // 10 years
  max_lease_ttl        = 157680000 // 5 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Cloud - OCI Prev"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-prev.path
  root_sign_common_name = "oci.prev.${local.common_name}"

  depends_on = [module.subca-prev]
}

module "subca-sand-azure" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-sand-azure"
  common_name          = "azure.sand.${local.common_name}"
  ttl                  = 315360000 // 10 years
  max_lease_ttl        = 157680000 // 5 years
  default_lease_ttl    = 31536000  // 1 year 
  key_bits             = 4096
  ou                   = "PKI Cloud - Azure Sand"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-sand.path
  root_sign_common_name = "azure.sand.${local.common_name}"

  depends_on = [module.subca-sand]
}

module "subca-sand-oci" {
  source               = "./modules/intermediate_ca"
  path                 = "pki/subca-sand-oci"
  common_name          = "oci.sand.${local.common_name}"
  ttl                  = 315360000 // 10 years
  max_lease_ttl        = 157680000 // 5 years
  default_lease_ttl    = 31536000  // 1 year
  key_bits             = 4096
  ou                   = "PKI Cloud - OCI Sand"
  organization         = "Customer Lab"
  root_mount_path      = module.subca-sand.path
  root_sign_common_name = "oci.sand.${local.common_name}"

  depends_on = [module.subca-sand]
}

## ROLES ##

module "subca-sand-azure-roles" {
  source         = "./modules/pki_role"
  for_each       = local.pki_roles

  pki_mount_path      = module.subca-sand-azure.path
  role_name           = "subca-sand-azure-${each.key}"
  allowed_domains     = ["azure.sand.${local.common_name}"]
  key_type            = each.value.key_type
  key_bits            = each.value.key_bits
  key_usage           = each.value.key_usage
  ext_key_usage       = each.value.ext_key_usage
  allow_any_name      = each.value.allow_any_name

  issuing_certificates     = ["${local.vault_address}/v1/pki/subca-sand-azure/ca"]
  crl_distribution_points  = ["${local.vault_address}/v1/pki/subca-sand-azure/crl"]
  issue_cert               = false

  depends_on = [module.subca-sand-azure]
}

module "subca-prev-azure-roles" {
  source         = "./modules/pki_role"
  for_each       = local.pki_roles

  pki_mount_path      = module.subca-prev-azure.path
  role_name           = "subca-prev-azure-${each.key}"
  allowed_domains     = ["azure.prev.${local.common_name}"]
  key_type            = each.value.key_type
  key_bits            = each.value.key_bits
  key_usage           = each.value.key_usage
  ext_key_usage       = each.value.ext_key_usage
  allow_any_name      = each.value.allow_any_name

  issuing_certificates     = ["https://${local.vault_address}/v1/pki/subca-prev-azure/ca"]
  crl_distribution_points  = ["https://${local.vault_address}/v1/pki/subca-prev-azure/crl"]
  issue_cert               = false

  depends_on = [module.subca-prev-azure]
}

module "subca-prod-azure-roles" {
  source         = "./modules/pki_role"
  for_each       = local.pki_roles

  pki_mount_path      = module.subca-prod-azure.path
  role_name           = "subca-prod-azure-${each.key}"
  allowed_domains     = ["azure.prod.${local.common_name}"]
  key_type            = each.value.key_type
  key_bits            = each.value.key_bits
  key_usage           = each.value.key_usage
  ext_key_usage       = each.value.ext_key_usage
  allow_any_name      = each.value.allow_any_name

  issuing_certificates     = ["https://${local.vault_address}/v1/pki/subca-prod-azure/ca"]
  crl_distribution_points  = ["https://${local.vault_address}/v1/pki/subca-prod-azure/crl"]
  issue_cert               = false

  depends_on = [module.subca-prod-azure]
}
