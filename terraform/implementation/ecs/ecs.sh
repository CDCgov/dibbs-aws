#!/bin/bash

# Load environment variables from .env file
if [ -f ../.env ]; then
    export $(cat ../.env | xargs)
fi

# set default values
ENVIRONMENT="${ENVIRONMENT:-}"
BUCKET="${BUCKET:-}"
DYNAMODB_TABLE="${DYNAMODB_TABLE:-}"
REGION="${REGION:-}"

# parse command line arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -env|--env|-e)
        ENVIRONMENT="$2"
        shift
        shift
        ;;
        -bucket|--bucket|-b)
        BUCKET="$2"
        shift
        shift
        ;;
        -dynamodb_table|--dynamodb-table|-d)
        DYNAMODB_TABLE="$2"
        shift
        shift
        ;;
        -region|--region|-r)
        REGION="$2"
        shift
        shift
        ;;
        -h|--help)
        echo "Usage: ./ecs.sh [OPTIONS]"
        echo "Options:"
        echo "  -e, --env            | Set the environment (e.g., production, staging) [REQUIRED]"
        echo "  -b, --bucket         | Set the bucket name [REQUIRED]"
        echo "  -d, --dynamodb-table | Set the DynamoDB table name [REQUIRED]"
        echo "  -r, --region         | Set the AWS region [REQUIRED]"
        echo "  -h, --help           | Show help"
        exit 0
        ;;
        *)
        echo "Invalid argument: $1"
        exit 1
        ;;
    esac
done

if [ -z "$ENVIRONMENT" ] || [ -z "$BUCKET" ] || [ -z "$DYNAMODB_TABLE" ] || [ -z "$REGION" ]; then
    echo "Missing required arguments. Please provide all the required arguments."
    ./ecs.sh -h
    exit 1
fi

if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform and try again."
    exit 1
fi

if [ ! -f "$ENVIRONMENT.tfvars" ]; then
    echo "No tfvars file exists, creating '$ENVIRONMENT.tfvars', use this to override variables"
    touch "$ENVIRONMENT.tfvars"
    exit 1
fi

echo "$ENVIRONMENT"

terraform init \
    -migrate-state \
    -var-file="$ENVIRONMENT.tfvars" \
    -backend-config "bucket=$BUCKET" \
    -backend-config "dynamodb_table=$DYNAMODB_TABLE" \
    -backend-config "region=$REGION" \
    || (echo "terraform init failed, exiting..." && exit 1)

# Check if workspace exists
if terraform workspace list | grep -q "$ENVIRONMENT"; then
    echo "Selecting $ENVIRONMENT terraform workspace"
    terraform workspace select "$ENVIRONMENT"
else
    read -p "Workspace '$ENVIRONMENT' does not exist. Do you want to create it? (y/n): " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        echo "Creating '$ENVIRONMENT' terraform workspace"
        terraform workspace new "$ENVIRONMENT"
    else
        echo "Workspace creation cancelled."
        exit 1
    fi
fi

terraform apply \
    -var-file="$ENVIRONMENT.tfvars"
