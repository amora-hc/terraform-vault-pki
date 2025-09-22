#!/usr/bin/env bash
set -e

COMPOSE_FILE="./docker-compose.yml"

echo "Destroying Jenkins (Docker Compose)..."
docker compose -f "$COMPOSE_FILE" down -v

rm -Rf ./casc/jobs/seed-job/builds
rm -Rf ./casc/jobs/seed-job/workspace
rm -Rf ./casc/jobs/seed-job/nextBuildNumber
rm -Rf ./casc/jobs/PKI*