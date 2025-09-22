#!/usr/bin/env bash
set -e

COMPOSE_FILE="./docker-compose.yml"
CONTAINER_NAME="jenkins-pki"

echo "Starting Jenkins (Docker Compose)..."
docker compose -f "$COMPOSE_FILE" up -d --build

echo "Jenkins and related services are up and running!"
docker compose -f "$COMPOSE_FILE" ps

echo "Waiting for Jenkins initial admin password..."
while ! docker exec "$CONTAINER_NAME" test -f /var/jenkins_home/secrets/initialAdminPassword; do
    sleep 1
done

ADMIN_PASS=$(docker exec "$CONTAINER_NAME" cat /var/jenkins_home/secrets/initialAdminPassword | tr -d '\r\n')
echo "Jenkins initial admin password: $ADMIN_PASS"
