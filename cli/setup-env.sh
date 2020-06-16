#!/usr/bin/env bash

# Copy and fill the main .env-example template to a new .env interactively

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'

function replace_env_var() {
  echo -e "${BLUE}Give me your $1 (default: $2): ${NC}"
  VAL=$(read -r INPUT && echo "$INPUT")
  if [ -z "$VAL" ]
  then
    echo "skip"
  else
    sed -i "s/.*$1=.*/$1=$VAL/g" "$3"
  fi
}

cp ../.env-example ../.env
echo -e "${BLUE}Let setup a new project for you, first we need to ask you some questions: ${NC}"
replace_env_var "APP_NAME" "my-app" ../.env
replace_env_var "DOMAIN" "my-app.local" ../.env
replace_env_var "DB_NAME" "my-app" ../.env
replace_env_var "DB_USER" "root" ../.env
replace_env_var "DB_PASSWORD" "password" ../.env
replace_env_var "XDEBUG_PORT" "9042" ../.env
replace_env_var "PHPMYADMIN_PORT" "8042" ../.env
replace_env_var "MYSQL_PORT" "3306" ../.env
replace_env_var "NGINX_HTTP_PORT" "80" ../.env
replace_env_var "NGINX_HTTPS_PORT" "443" ../.env

sed -i "s/.*CONTAINER_USER=.*/CONTAINER_USER=$(id -u):$(id -g)/g" ../.env

echo -e "${GREEN}Your .env file has been created${NC}"
