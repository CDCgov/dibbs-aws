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
TERRAFORM_ROLE="${TERRAFORM_ROLE:-}"
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
        -dynamodb-table|--dynamodb-table|-d)
        DYNAMODB_TABLE="$2"
        shift
        shift
        ;;
        -region|--region|-r)
        REGION="$2"
        shift
        shift
        ;;
        -terraform-role|--terraform-role)
        TERRAFORM_ROLE="$2"
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

# Danger zone! Destroy the ECS cluster
terraform init \
    -var-file="$ENVIRONMENT.tfvars" \
    -backend-config "bucket=$BUCKET" \
    -backend-config "dynamodb_table=$DYNAMODB_TABLE" \
    -backend-config "region=$REGION" \
    || (echo "terraform init failed, exiting..." && exit 1)

terraform destroy -auto-approve -var-file="$ENVIRONMENT.tfvars"
