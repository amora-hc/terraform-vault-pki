#!/bin/bash
#set -eu
#set -euxo pipefail
set +x

# Fetch serials from Vault
SERIAL_JSON=$(vault list -format=json -ns "$VAULT_NAMESPACE" "${PKI_MOUNT}/certs")

# Check if null or empty
if [ "$SERIAL_JSON" = "null" ] || [ -z "$SERIAL_JSON" ]; then
    echo "No certificates found."
    exit 0
fi

# Convert JSON array to Bash array
readarray -t SERIALS < <(echo "$SERIAL_JSON" | jq -r '.[]')

# Loop through serials
for SERIAL in "${SERIALS[@]}"; do
    # Fetch certificate data
    CERT_JSON=$(vault read -format=json -ns "$VAULT_NAMESPACE" "${PKI_MOUNT}/cert/$SERIAL" | jq -r '.data')

    # Print header
    echo "---------------------------------------------------"
    
    # Print path and serial
    echo "Path: ${PKI_MOUNT}/cert/$SERIAL"
    echo "Serial: $SERIAL"
    echo "All Metadata Fields:"

    # Dynamically list all metadata keys and values
    echo "$CERT_JSON" | jq -r 'to_entries[] | "  \(.key): \(.value)"'

    echo "---------------------------------------------------"
done
