#!/bin/bash

cd ../implementation/ecs || exit 1
echo "Init graph..."
export $(cat .env | xargs)
terraform init \
  -var-file="$WORKSPACE.tfvars" \
  -backend-config "bucket=$BUCKET" \
  -backend-config "dynamodb_table=$DYNAMODB_TABLE" \
  -backend-config "region=$REGION" \
  || (echo "terraform init failed, this error came from tfgraph.sh, you may need to setup a tfvars file..." && exit 1)
echo "Generating graph..."
terraform graph -draw-cycles | dot -Tpng >graph.png
cd - || exit 1
