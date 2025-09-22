#!/bin/bash

export VAULT_NAMESPACE=admin
export HTTPS_PROXY=http://eproxy-bccprod.de.goskope.com:8081
export VAULT_ADDR=https://bcc-vault-cluster-01-public-vault-eaeedc1a.1264f742.z1.hashicorp.cloud:8200

vault write identity/entity name="entity_approle" policies="hcp-root" #Entity ID

#Win server

vault auth enable -path=approle-win approle

vault write auth/approle-win/role/windows-server \
  token_policies="hcp-root" \
  secret_id_ttl=0 \
  secret_id_num_uses=0 \
  token_ttl=1h \
  token_max_ttl=4h

vault read auth/approle-win/role/windows-server/role-id #Role ID
vault auth list -detailed | grep approle-win #AppRole mount accessor

vault write identity/entity-alias \
  name="c9bc2b48-0e3d-0782-96d6-1ce14b9f33db" \
  canonical_id="47473d62-e37a-5ba3-1fc6-527570295bdc" \
  mount_accessor="auth_approle_98e9f20b"
 
vault write -f auth/approle-win/role/windows-server/secret-id  #Secret ID

vault write auth/approle-win/login \
  role_id="c9bc2b48-0e3d-0782-96d6-1ce14b9f33db" \
  secret_id="4e6fbf3f-12f6-87e8-4c1e-0db84b18f4f2"
