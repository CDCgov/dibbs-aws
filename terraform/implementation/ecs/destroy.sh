#!/bin/bash

# Danger zone! Destroy the ECS cluster
terraform destroy -auto-approve -var-file="$1.tfvars"
