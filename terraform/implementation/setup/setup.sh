#!/bin/bash

# Load environment variables from .env file
if [ -f ../.env ]; then
    export $(cat ../.env | xargs)
fi

# set default values
ENVIRONMENT="${ENVIRONMENT:-}"

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        -env|--env|-e)
        ENVIRONMENT="$2"
        shift
        shift
        ;;
        -h|--help)
        echo "Usage: ./ecs.sh [OPTIONS]"
        echo "Options:"
        echo "  -e, --env            | Set the environment (e.g., production, staging) [REQUIRED]"
        echo "  -h, --help           | Show help"
        exit 0
        ;;
        *)
        echo "Invalid argument: $1"
        exit 1
        ;;
    esac
done

if [ -z "$ENVIRONMENT" ]; then
    echo "Missing required arguments. Please provide all the required arguments."
    ./setup.sh -h
    exit 1
fi

if ! command -v terraform &> /dev/null; then
    echo "Terraform is not installed. Please install Terraform and try again."
    exit 1
fi

if [ ! -f "$ENVIRONMENT.tfvars" ]; then
    echo "Creating $ENVIRONMENT.tfvars"
    touch "$ENVIRONMENT.tfvars"
fi

if ! grep -q "owner" "$ENVIRONMENT.tfvars"; then
    read -p "Who is the owner of this infrastructure? default=skylight" owner_choice
    owner_choice=${owner_choice:-skylight}
    echo "owner = \"$owner_choice\"" >> "$ENVIRONMENT.tfvars"
fi

if ! grep -q "project" "$ENVIRONMENT.tfvars"; then
    read -p "What is this project called? default=dibbs" project_choice
    project_choice=${project_choice:-dibbs}
    echo "project  = \"$project_choice\"" >> "$ENVIRONMENT.tfvars"
fi

if ! grep -q "region" "$ENVIRONMENT.tfvars"; then
    read -p "What aws region are you setting up in? default=us-east-1" region_choice
    region_choice=${region_choice:-us-east-1}
    echo "region  = \"$region_choice\"" >> "$ENVIRONMENT.tfvars"
fi

terraform init -var-file="$ENVIRONMENT.tfvars"
terraform apply -var-file="$ENVIRONMENT.tfvars"
