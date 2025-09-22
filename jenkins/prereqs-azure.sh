#!/usr/bin/env bash
set -o pipefail

SUBSCRIPTION_ID="<SUBSCRIPTION_ID>"
RESOURCE_GROUP="<RESOURCE_GROUP>"
VAULT_NAME="<VAULT_NAME>"
SP_NAME="<SP_NAME>"
SP_ROLE="Contributor"
VAULT_ROLE="Key Vault Certificates Officer"
VAULT_ROLE_ADMIN="Key Vault Administrator"
SCOPE_VAULT="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP}/providers/Microsoft.KeyVault/vaults/${VAULT_NAME}"

# Create Service Principal for Vault Agent
echo "Creating Service Principal for Vault Agent..."
az ad sp create-for-rbac \
  --name "${SP_NAME}" \
  --role "${SP_ROLE}" \
  --scopes "/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP}" \
  --output json > sp_credentials.json

# Create resource group and key vault
echo "Creating resource group and key vault..."
az keyvault create --name "${VAULT_NAME}" --resource-group "${RESOURCE_GROUP}"

# Extract appId, password, tenant
CLIENT_ID=$(jq -r '.appId' sp_credentials.json)
CLIENT_SECRET=$(jq -r '.password' sp_credentials.json)
TENANT_ID=$(jq -r '.tenant' sp_credentials.json)

echo "Service Principal created with clientId: ${CLIENT_ID}"

# Assign Key Vault roles for the SP
echo "Assigning Key Vault roles..."
az role assignment create \
  --assignee "${CLIENT_ID}" \
  --role "${VAULT_ROLE}" \
  --scope "${SCOPE_VAULT}"

az role assignment create \
  --assignee "${CLIENT_ID}" \
  --role "${VAULT_ROLE_ADMIN}" \
  --scope "${SCOPE_VAULT}"

# Jenkins plugin
echo "Subscription ID: ${SUBSCRIPTION_ID}"
echo "Client ID: ${CLIENT_ID}"
echo "Client Secret: ${CLIENT_SECRET}"
echo "Tenant ID: ${TENANT_ID}"
