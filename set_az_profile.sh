#!/bin/bash

SECRET_NAME="AZURE_FUNCTIONAPP_PUBLISH_PROFILE"

FILE="./current.PublishSettings"

if [ ! -f "$FILE" ]; then
    echo "Error: JSON file does not exist: $FILE"
    exit 1
fi

GH_USER="northcoders-dev"

GH_REPO="bootcamp_benchmark"

SECRET_VALUE=$(cat "$FILE")

# Create or update 'AZURE_CREDENTIALS' GitHub secret
echo "$SECRET_VALUE" | gh secret set $SECRET_NAME -R$GH_USER/$GH_REPO
