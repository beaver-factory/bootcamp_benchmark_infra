#!/bin/bash

# Name of the secret
SECRET_NAME="AZURE_CREDENTIALS"

# Path to the JSON file
JSON_FILE="./config.json"

# Check if the JSON file exists
if [ ! -f "$JSON_FILE" ]; then
    echo "Error: JSON file does not exist: $JSON_FILE"
    exit 1
fi

# Your GitHub username (or organization name)
GH_USER="northcoders-dev"

# Your repository name
GH_REPO="bootcamp_benchmark"

# Read the JSON file and remove newline characters
SECRET_VALUE=$(tr -d '\n' < "$JSON_FILE")

# Create or update the GitHub secret
echo "$SECRET_VALUE" | gh secret set $SECRET_NAME -R$GH_USER/$GH_REPO
