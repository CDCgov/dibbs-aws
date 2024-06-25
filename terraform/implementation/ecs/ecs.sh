#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | xargs)
fi

# set default values
ENVIRONMENT="${ENVIRONMENT:-}"
BUCKET="${BUCKET:-}"
DYNAMODB_TABLE="${DYNAMODB_TABLE:-}"
REGION="${REGION:-}"
CI=false

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
        -ci|--ci)
        CI=true
        shift
        ;;
        -h|--help)
        echo "Usage: ./ecs.sh [OPTIONS]"
        echo "Options:"
        echo "  -e, --env            | Set the environment (e.g., production, staging) [REQUIRED]"
        echo "  -b, --bucket         | Set the bucket name [REQUIRED]"
        echo "  -d, --dynamodb-table | Set the DynamoDB table name [REQUIRED]"
        echo "  -r, --region         | Set the AWS region [REQUIRED]"
        echo "  -ci, --ci            | Skip creating files and assume all arguments have values"
        echo "  -h, --help           | Show help"
        exit 0
        ;;
        *)
        echo "Invalid argument: $1"
        exit 1
        ;;
    esac
done

if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform and try again."
    exit 1
fi

if [ -z "$ENVIRONMENT" ] || [ -z "$BUCKET" ] || [ -z "$DYNAMODB_TABLE" ] || [ -z "$REGION" ]; then
    echo "Missing required arguments. Please provide all the required arguments."
    echo "ENVIRONMENT: $ENVIRONMENT"
    echo "BUCKET: $BUCKET"
    echo "DYNAMODB_TABLE: $DYNAMODB_TABLE"
    echo "REGION: $REGION"
    ./ecs.sh -h
    exit 1
fi

if [ "$CI" = false ]; then
    if [ ! -f "$ENVIRONMENT.tfvars" ]; then
        echo "Creating $ENVIRONMENT.tfvars"
        touch "$ENVIRONMENT.tfvars"
    fi

    if ! grep -q "owner" "$ENVIRONMENT.tfvars"; then
        read -p "Who is the owner of this infrastructure? ( default=skylight ): " owner_choice
        owner_choice=${owner_choice:-skylight}
        echo "owner = \"$owner_choice\"" >> "$ENVIRONMENT.tfvars"
    fi

    if ! grep -q "project" "$ENVIRONMENT.tfvars"; then
        read -p "What is this project called? ( default=dibbs ): " project_choice
        project_choice=${project_choice:-dibbs}
        echo "project = \"$project_choice\"" >> "$ENVIRONMENT.tfvars"
    fi

    if ! grep -q "region" "$ENVIRONMENT.tfvars"; then
        read -p "What aws region are you setting up in? ( default=us-east-1 ): " region_choice
        region_choice=${region_choice:-us-east-1}
        echo "region = \"$region_choice\"" >> "$ENVIRONMENT.tfvars"
    fi
fi

echo "Running Terraform with the following variables:"
echo "Environment: $ENVIRONMENT"
echo "Terraform Workspace: $ENVIRONMENT"
echo "Bucket: $BUCKET"
echo "DynamoDB Table: $DYNAMODB_TABLE"
echo "Region: $REGION"
cat "$ENVIRONMENT.tfvars"

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
    if [ "$CI" = false ]; then
        read -p "Workspace '$ENVIRONMENT' does not exist. Do you want to create it? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
            echo "Creating '$ENVIRONMENT' terraform workspace"
            terraform workspace new "$ENVIRONMENT"
        else
            echo "Workspace creation cancelled."
            exit 1
        fi
    else
        echo "Creating '$ENVIRONMENT' terraform workspace"
        terraform workspace new "$ENVIRONMENT"
    fi
fi

if [ "$CI" = false ]; then
    terraform apply -var-file="$ENVIRONMENT.tfvars"
else
    terraform apply -auto-approve -var-file="$ENVIRONMENT.tfvars"
fi