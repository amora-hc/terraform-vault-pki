#!/bin/bash

vault auth enable approle || true

vault write auth/approle/role/jenkins \
    token_policies="hcp-root" \
    secret_id_ttl=0 \
    secret_id_num_uses=0 \
    token_ttl=1h \
    token_max_ttl=4h

vault read auth/approle/role/jenkins/role-id
            
vault write -f auth/approle/role/jenkins/secret-id
