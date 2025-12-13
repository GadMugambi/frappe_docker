#!/bin/bash
set -e

echo "Building ERPNext Healthcare Production Image..."

# Load environment
source production.env

# Generate base64 apps.json
export APPS_JSON_BASE64=$(base64 -w 0 apps.json)

# Build image
docker build \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=${CUSTOM_IMAGE}:${CUSTOM_TAG} \
  --tag=${CUSTOM_IMAGE}:latest \
  --file=images/layered/Containerfile \
  --progress=plain \
  .

echo "Build complete!"
echo "Image: ${CUSTOM_IMAGE}:${CUSTOM_TAG}"
