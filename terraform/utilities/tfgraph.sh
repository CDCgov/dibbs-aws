#!/bin/bash

cd ../implementation/ecs || exit 1
terraform init -input=false
terraform graph -draw-cycles | dot -Tpng >graph.png
cd - || exit 1
