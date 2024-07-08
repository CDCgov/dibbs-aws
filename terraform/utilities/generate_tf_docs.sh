#!/bin/bash

terraform-docs markdown table --output-file README.md --output-mode inject ../modules/ecr
terraform-docs markdown table --output-file README.md --output-mode inject ../modules/ecs
terraform-docs markdown table --output-file README.md --output-mode inject ../implementation/ecs
terraform-docs markdown table --output-file README.md --output-mode inject ../implementation/setup
