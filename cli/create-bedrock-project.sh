#!/usr/bin/env bash

# Create a new bedrock project with docker-compose and .env configuration

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

cd ../
source ./.env

mkdir -p src/$APP_NAME

docker-compose run composer create-project roots/bedrock ./
