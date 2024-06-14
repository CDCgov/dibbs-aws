#!/bin/bash

# set environment variables
ENVIRONMENT=$1
PRODUCTION="production"

if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform and try again."
    exit 1
fi

# check if $PRODUCTION or other environment
if [ "$ENVIRONMENT" == "$PRODUCTION" ]; then
    terraform init -var-file="$PRODUCTION.tfvars"
    terraform plan -var-file="$PRODUCTION.tfvars"
elif [ "$ENVIRONMENT" != "$PRODUCTION" ] && [ "$ENVIRONMENT" != "" ]; then
    echo "$ENVIRONMENT"
    terraform init -var-file="$ENVIRONMENT.tfvars"
    terraform plan -var-file="$ENVIRONMENT.tfvars"
else
    echo "Please provide a valid environment: $PRODUCTION or another string"
    exit 1
fi
