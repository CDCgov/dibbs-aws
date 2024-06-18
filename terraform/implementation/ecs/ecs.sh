#!/bin/bash

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
    terraform init \
        -migrate-state \
        -var-file="$ENVIRONMENT.tfvars" \
        -backend-config "bucket=dibbs-aws-tfstate-alis-default" \
        -backend-config "dynamodb_table=dibbs-aws-tfstate-lock-alis-default" \
        -backend-config "region=us-east-1"
    # terraform plan \
    #     -var-file="$ENVIRONMENT.tfvars" \
    #     -target=module.vpc -target=module.iam -target=module.ecr -target=module.s3 -target=module.ecs
    terraform apply \
        -var-file="$ENVIRONMENT.tfvars" \
        -target=module.vpc -target=module.iam -target=module.ecr -target=module.s3 -target=module.ecs -target=module.ecs
else
    echo "Please provide a valid environment: $PRODUCTION or another string"
    exit 1
fi


# terraform init \
#     -backend-config "bucket=dibbs-aws-tfstate-alis-default" \
#     -backend-config "dynamodb_table=dibbs-aws-tfstate-lock-alis-default" \
#     -backend-config "region=us-east-1" \
#     -var-file="$ENVIRONMENT.tfvars"
# terraform plan \
#     -backend-config "bucket=dibbs-aws-tfstate-alis-default" \
#     -backend-config "dynamodb_table=dibbs-aws-tfstate-lock-alis-default" \
#     -backend-config "region=us-east-1" \
#     -var-file="$ENVIRONMENT.tfvars"