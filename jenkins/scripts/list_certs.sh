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

# Print table header
printf "%-65s %-20s %-30s %-35s %-25s %-10s\n" "Serial Number" "PKI Mount" "Issuer CN" "Subject CN" "Expiry Date" "Status"
printf "%-65s %-20s %-30s %-35s %-25s %-10s\n" "-------------" "--------" "----------" "----------" "-----------" "------"

# Loop through serials
for SERIAL in "${SERIALS[@]}"; do
    # Fetch certificate data
    CERT_JSON=$(vault read -format=json -ns "$VAULT_NAMESPACE" "${PKI_MOUNT}/cert/$SERIAL" | jq -r '.data')

    # Extract fields
    SERIAL_NUM="$SERIAL"
    PKI_NAME="$PKI_MOUNT"
    ROLE=$(echo "$CERT_JSON" | jq -r '.role_name // "N/A"')

    # Extract certificate PEM and save to temp file
    CERT_PEM=$(echo "$CERT_JSON" | jq -r '.certificate')
    TEMP_CERT_FILE=$(mktemp /tmp/cert_XXXXXX.pem)
    echo "$CERT_PEM" > "$TEMP_CERT_FILE"
    
    # openssl x509 -in $TEMP_CERT_FILE -noout -text
    
    # Extract CN from Issuer and Subject
    ISSUER_CN=$(openssl x509 -noout -issuer -in "$TEMP_CERT_FILE" | sed -n 's/^issuer=.*CN = *\([^,]*\).*$/\1/p')
    SUBJECT_CN=$(openssl x509 -noout -subject -in "$TEMP_CERT_FILE" | sed -n 's/^subject=.*CN = *\([^,]*\).*$/\1/p')

    # Extract expiry date using openssl
    EXPIRY_DATE=$(openssl x509 -enddate -noout -in "$TEMP_CERT_FILE" | cut -d'=' -f2)

    # Cleanup temp file
    rm -f "$TEMP_CERT_FILE"

    # Determine certificate status based on expiry
    EXPIRY_EPOCH=$(date -d "$EXPIRY_DATE" +%s 2>/dev/null || echo 0)
    NOW_EPOCH=$(date +%s)

    if [ "$EXPIRY_EPOCH" -gt "$NOW_EPOCH" ]; then
        STATUS="active"
    else
        STATUS="expired"
    fi

    printf "%-65s %-20s %-30s %-35s %-25s %-10s\n" "$SERIAL_NUM" "$PKI_NAME" "$ISSUER_CN" "$SUBJECT_CN" "$EXPIRY_DATE" "$STATUS"
done
