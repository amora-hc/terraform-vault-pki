#!/bin/bash

export VAULT_NAMESPACE=admin
export HTTPS_PROXY=http://eproxy-bccprod.de.goskope.com:8081
export VAULT_ADDR=https://bcc-vault-cluster-01-public-vault-eaeedc1a.1264f742.z1.hashicorp.cloud:8200

#HCPRequester
vault write auth/oidc/role/operator -<< EOF
{
    "allowed_redirect_uris": '["http://localhost:8250/oidc/callback","https://bcc-vault-cluster-01-public-vault-eaeedc1a.1264f742.z1.hashicorp.cloud:8200/ui/vault/auth/oidc/oidc/callback"]',
    "user_claim": "email",
    "groups_claim": "groups",
    "bound_claims": {"groups": ["06cef478-09f8-4449-be5d-d960d1edfdfc"]},
    "oidc_scopes": "https://graph.microsoft.com/.default",
    "policies": "hcp-operator",
    "role_type": "oidc"
}
EOF

vault write identity/group \
  name="hcprequester" \
  type="external" \
  policies="hcp-operator"

vault policy write hcp-operator operator-policy.hcl

vault auth list -detailed | grep -A2 oidc #oidc auth mount accessor
vault read identity/group/id/hcprequester #id

vault write identity/group-alias \
  name="06cef478-09f8-4449-be5d-d960d1edfdfc" \
  mount_accessor="auth_oidc_13a25853" \
  canonical_id="9d44af2b-d7d9-5add-5711-e2ea887f0a51"

#HCPBrowser
vault write auth/oidc/role/readonly -<< EOF
{
    "allowed_redirect_uris": ["http://localhost:8250/oidc/callback","https://bcc-vault-cluster-01-public-vault-eaeedc1a.1264f742.z1.hashicorp.cloud:8200/ui/vault/auth/oidc/oidc/callback"],
    "user_claim": "email",
    "groups_claim": "groups",
    "bound_claims": {"groups": ["d347bfc1-2d34-4d5f-8e3c-386c11499684"]},
    "oidc_scopes": "https://graph.microsoft.com/.default",
    "policies": "hcp-readonly",
    "role_type": "oidc"
}
EOF

vault write identity/group \
  name="hcpbrowser" \
  type="external" \
  policies="hcp-readonly"

vault policy write hcp-readonly readonly-policy.hcl

vault auth list -detailed | grep -A2 oidc #oidc auth mount accessor
vault read identity/group/id/hcpbrowser #id

vault write identity/group-alias \
  name="d347bfc1-2d34-4d5f-8e3c-386c11499684" \
  mount_accessor="auth_oidc_36b97d92" \
  canonical_id="9d44af2b-d7d9-5add-5711-e2ea887f0a51"
