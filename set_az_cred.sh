#!/bin/bash

SECRET_NAME="AZURE_CREDENTIALS"

JSON_FILE="./creds.json"

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: JSON file does not exist: $JSON_FILE"
    exit 1
fi

GH_USER="northcoders-dev"

GH_REPO="bootcamp_benchmark"

SECRET_VALUE=$(tr -d '\n' < "$JSON_FILE")

# Create or update 'AZURE_CREDENTIALS' GitHub secret
echo "$SECRET_VALUE" | gh secret set $SECRET_NAME -R$GH_USER/$GH_REPO
