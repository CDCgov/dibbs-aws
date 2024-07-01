#!/bin/bash

terraform-docs markdown table --output-file README.md --output-mode inject terraform/modules/ecr
terraform-docs markdown table --output-file README.md --output-mode inject terraform/modules/ecs
terraform-docs markdown table --output-file README.md --output-mode inject terraform/implementation/ecs
terraform-docs markdown table --output-file README.md --output-mode inject terraform/implementation/setup
