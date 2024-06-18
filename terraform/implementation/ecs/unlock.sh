#!/bin/bash

terraform force-unlock $1

aws ecr get-login-password | docker login --username AWS --password-stdin 339712971032.dkr.ecr.us-east-1.amazonaws.com