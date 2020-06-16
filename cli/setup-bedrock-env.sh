#!/usr/bin/env bash

# Add proper env configuration on newly bedrock generated .env into src/APP_NAME

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
NC='\033[0m'


source "../.env"

BEDROCK_ENV_PATH="../src/$APP_NAME/.env"
cp $BEDROCK_ENV_PATH "$BEDROCK_ENV_PATH.old"

ENVFILE="$BEDROCK_ENV_PATH"

sed -i "s .*DB_NAME=.* DB_NAME='$DB_NAME' g" "$ENVFILE"
sed -i "s .*DB_USER=.* DB_USER='$DB_USER' g" "$ENVFILE"
sed -i "s .*DB_HOST=.* DB_HOST='$DB_HOST' g" "$ENVFILE"
sed -i "s .*DB_PASSWORD=.* DB_PASSWORD='$DB_ROOT_PASSWORD' g" "$ENVFILE"
sed -i "s .*DB_PREFIX=.* DB_PREFIX='$DB_TABLE_PREFIX' g" "$ENVFILE"
sed -i "s .*WP_HOME=.* WP_HOME='http://$DOMAIN' g" "$ENVFILE"
sed -i "s .*WP_DEBUG_LOG=.* WP_DEBUG_LOG='/tmp/wp-debug.log' g" "$ENVFILE"

echo -e "${BLUE}Generate then copy/paste secret keys Env Format from: https://roots.io/salts.html${NC}"
AUTH_KEY=$(read -r INPUT && echo "$INPUT")
SECURE_AUTH_KEY=$(read -r INPUT && echo "$INPUT")
LOGGED_IN_KEY=$(read -r INPUT && echo "$INPUT")
NONCE_KEY=$(read -r INPUT && echo "$INPUT")
AUTH_SALT=$(read -r INPUT && echo "$INPUT")
SECURE_AUTH_SALT=$(read -r INPUT && echo "$INPUT")
LOGGED_IN_SALT=$(read -r INPUT && echo "$INPUT")
NONCE_SALT=$(read -r INPUT && echo "$INPUT")

# Remove then append lines because of special characters colision with sed
sed -i "/.*AUTH_KEY=.*/d" "$ENVFILE"
sed -i "/.*SECURE_AUTH_KEY=.*/d" "$ENVFILE"
sed -i "/.*LOGGED_IN_KEY=.*/d" "$ENVFILE"
sed -i "/.*NONCE_KEY=.*/d" "$ENVFILE"
sed -i "/.*AUTH_SALT=.*/d" "$ENVFILE"
sed -i "/.*SECURE_AUTH_SALT=.*/d" "$ENVFILE"
sed -i "/.*LOGGED_IN_SALT=.*/d" "$ENVFILE"
sed -i "/.*NONCE_SALT=.*/d" "$ENVFILE"
echo $AUTH_KEY >> "$ENVFILE"
echo $SECURE_AUTH_KEY >> "$ENVFILE"
echo $LOGGED_IN_KEY >> "$ENVFILE"
echo $NONCE_KEY >> "$ENVFILE"
echo $AUTH_SALT >> "$ENVFILE"
echo $SECURE_AUTH_SALT >> "$ENVFILE"
echo $LOGGED_IN_SALT >> "$ENVFILE"
echo $NONCE_SALT >> "$ENVFILE"

echo -e "${GREEN}Bedrock .env setted${NC}"
