locals {
  vault_address = "https://cajamar-vault-cluster-public-vault-0ddf944f.c8765019.z1.hashicorp.cloud:8200"
  common_name   = "cajamar.internal"
  pki_roles = {
    sign-doc = {
      key_type              = "rsa"
      key_bits              = 4096
      key_usage             = ["digitalSignature"]
      ext_key_usage         = []
      allow_any_name        = false
    }
    ssl-public = {
      key_type              = "rsa"
      key_bits              = 2048
      key_usage             = ["digitalSignature", "keyEncipherment"]
      ext_key_usage         = ["serverAuth"]
      allow_any_name        = false
    }
    client-auth = {
      key_type              = "rsa"
      key_bits              = 2048
      key_usage             = ["digitalSignature", "keyEncipherment"]
      ext_key_usage         = ["clientAuth"]
      allow_any_name        = true
    }
    balancer-cert = {
      key_type              = "rsa"
      key_bits              = 2048
      key_usage             = ["digitalSignature", "keyEncipherment"]
      ext_key_usage         = ["serverAuth"]
      allow_any_name        = false
    }
    code-sign = {
      key_type              = "rsa"
      key_bits              = 4096
      key_usage             = ["digitalSignature"]
      ext_key_usage         = ["codeSigning"]
      allow_any_name        = false
    }
    server-auth = {
      key_type              = "rsa"
      key_bits              = 2048
      key_usage             = ["digitalSignature", "keyEncipherment"]
      ext_key_usage         = ["serverAuth"]
      allow_any_name        = false
    }
    vpn-cert = {
      key_type              = "rsa"
      key_bits              = 2048
      key_usage             = ["digitalSignature", "keyEncipherment"]
      ext_key_usage         = ["ipsecEndSystem"]
      allow_any_name        = false
    }
    mdm-cert = {
      key_type              = "rsa"
      key_bits              = 2048
      key_usage             = ["digitalSignature", "keyEncipherment"]
      ext_key_usage         = ["clientAuth", "serverAuth"]
      allow_any_name        = false
    }
  }
}