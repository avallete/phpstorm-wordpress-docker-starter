#!/usr/bin/env bash

# Completely create and setup a new bedrock project from scratch

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

source ./setup-env.sh
source ./setup-hosts-file.sh
source ./create-cert.sh

cd $SCRIPTPATH
read -p "Do you want to trust the newly generated certs (y/n)?" choice
case "$choice" in
  y|Y ) source ./trust-cert.sh;;
  n|N ) echo "skip";;
  * ) echo "";;
esac

source ./create-bedrock-project.sh
cd $SCRIPTPATH
source ./setup-bedrock-env.sh

source ../.env
echo -e "${GREEN}Project has been fully created !${NC}"

read -p "Do you want to setup phpstorm config for your new project ? (y/n)?" choice
case "$choice" in
  y|Y ) source ./setup-phpstorm-template.sh;;
  n|N ) echo "skip";;
  * ) echo "";;
esac

echo -e "${BLUE}You can run the server with: docker-compose up -d${NC}"
echo -e "Then go to: ${YELLOW}https://${DOMAIN}${NC} your site should be up and running"
echo -e "${YELLOW}To avoid file permissions error, you should run:${NC}"
echo -e "To use composer easily, you should use: ${BLUE}docker-compose run composer install|require|...${NC}"
echo -e "Some infos on the running services:"
echo -e "phpmyadmin: ${YELLOW}http://0.0.0.0:8042${NC}"
