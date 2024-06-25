#!/bin/bash

# set default values
ENVIRONMENT="${ENVIRONMENT:-default}"

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

if ! grep -q "github_repo" "$ENVIRONMENT.tfvars"; then
    read -p "Are you using GitHub for your source control? (y/n): " github_choice
    if [[ "$github_choice" =~ ^[Yy]$ ]]; then
        read -p "What is the organization/repo value for assume role? ( default=\"\" ): " repo_choice
        repo_choice=${repo_choice:-""}
        echo "github_repo = \"$repo_choice\"" >> "$ENVIRONMENT.tfvars"
    fi
fi

echo "Running Terraform with the following variables:"
cat "$ENVIRONMENT.tfvars"

terraform init -var-file="$ENVIRONMENT.tfvars"
terraform apply -var-file="$ENVIRONMENT.tfvars"
