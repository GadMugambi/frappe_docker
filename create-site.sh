#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Usage: ./create-site.sh <site-name>"
    echo "Example: ./create-site.sh client1.yourcompany.com"
    exit 1
fi

SITE_NAME=$1
ADMIN_PASSWORD=${2:-admin123}  # Default password if not provided

echo "Creating site: $SITE_NAME"

# Load environment
source production.env

# Create site
docker compose -p erpnext-production exec backend \
  bench new-site \
    --mariadb-user-host-login-scope='%' \
    --db-root-password=${DB_PASSWORD} \
    --admin-password=${ADMIN_PASSWORD} \
    --install-app=erpnext \
    --install-app=healthcare \
    --install-app=hrms \
    ${SITE_NAME}

echo "Site created successfully!"
echo "URL: https://${SITE_NAME}"
echo "Username: Administrator"
echo "Password: ${ADMIN_PASSWORD}"
