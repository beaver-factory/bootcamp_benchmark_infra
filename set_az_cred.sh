#!/bin/bash

SECRET_NAME="AZURE_CREDENTIALS_2"

JSON_FILE="./creds.json"

if [ ! -f "$JSON_FILE" ]; then
    echo "Error: JSON file does not exist: $JSON_FILE"
    exit 1
fi

GH_USER="northcoders-dev"

GH_INFRA_REPO="bootcamp_benchmark_infra"
GH_FUNC_REPO="bootcamp_benchmark"

SECRET_VALUE=$(tr -d '\n' < "$JSON_FILE")

# Create or update 'AZURE_CREDENTIALS' GitHub secret, needed by 
echo "$SECRET_VALUE" | gh secret set $SECRET_NAME -R $GH_USER/$GH_INFRA_REPO
echo "$SECRET_VALUE" | gh secret set $SECRET_NAME -R $GH_USER/$GH_FUNC_REPO

# Create individual secrets needed by Terraform
echo $(echo $SECRET_VALUE | jq -r '.clientId') | gh secret set ARM_CLIENT_ID -R $GH_USER/$GH_INFRA_REPO
echo $(echo $SECRET_VALUE | jq -r '.clientSecret') | gh secret set ARM_CLIENT_SECRET -R $GH_USER/$GH_INFRA_REPO
echo $(echo $SECRET_VALUE | jq -r '.subscriptionId') | gh secret set ARM_SUBSCRIPTION_ID -R $GH_USER/$GH_INFRA_REPO
echo $(echo $SECRET_VALUE | jq -r '.tenantId') | gh secret set ARM_TENANT_ID -R $GH_USER/$GH_INFRA_REPO


source .env
if [ -z "$PSQL_PASSWORD" ] || [ -z "$EXCEPTION_ACTION_GROUP_SERVICE_URI" ]; then
    echo "PSQL_PASSWORD or EXCEPTION_ACTION_GROUP_SERVICE_URI not set in .env"
    exit 1
fi
echo $PSQL_PASSWORD | gh secret set TF_VAR_admin_password -R $GH_USER/$GH_INFRA_REPO
echo $EXCEPTION_ACTION_GROUP_SERVICE_URI | gh secret set TF_VAR_exception_action_group_service_uri -R $GH_USER/$GH_INFRA_REPO