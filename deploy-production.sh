#!/bin/bash
set -e

echo "Deploying ERPNext Healthcare to Production..."

# Load environment
source production.env

# Pull latest images (if not building locally)
# docker compose -f docker-compose.production.yaml pull

# Start services
docker compose -p erpnext-production -f docker-compose.production.yaml up -d

echo "Deployment complete!"
echo "Waiting for services to be ready..."
sleep 10

# Check status
docker compose -p erpnext-production -f docker-compose.production.yaml ps
