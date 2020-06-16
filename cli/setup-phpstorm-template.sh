#!/usr/bin/env bash

# Create a proper .idea configuration at the root of our project

set -e

GREEN='\033[0;32m'
NC='\033[0m'

echo -e "Setup .idea phpstorm configuration:"

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source "../.env"

APP_IDEA_PATH="$SCRIPTPATH/../src/$APP_NAME/.idea"
INTERPRETER_PHP_UUID="$(uuidgen)"
INTERPRETER_COMPOSER_UUID="$(uuidgen)"
VOLUMES_BINDING_UUID="$(uuidgen)"
DEPLOY_SERVER_UUID="$(uuidgen)"
HTTPS_SERVER_UUID="$(uuidgen)"
HTTP_SERVER_UUID="$(uuidgen)"

mkdir -p "$APP_IDEA_PATH"

# Files who wont change between projects
cp ../idea-template/.gitignore "$APP_IDEA_PATH/.gitignore"
cp ../idea-template/misc.xml "$APP_IDEA_PATH/misc.xml"
cp ../idea-template/vcs.xml "$APP_IDEA_PATH/vcs.xml"

cp ../idea-template/project.iml "$APP_IDEA_PATH/$APP_NAME.iml"
sed "s/%APP_NAME%/$APP_NAME/g" ../idea-template/modules.xml > "$APP_IDEA_PATH/modules.xml"
sed "s/%INTERPRETER_PHP_UUID%/$INTERPRETER_PHP_UUID/g" ../idea-template/php.xml | \
sed "s/%INTERPRETER_COMPOSER_UUID%/$INTERPRETER_COMPOSER_UUID/g" > "$APP_IDEA_PATH/php.xml"
sed "s/%VOLUMES_BINDING_UUID%/$VOLUMES_BINDING_UUID/g" ../idea-template/php-docker-settings.xml > "$APP_IDEA_PATH/php-docker-settings.xml"
sed "s/%INTERPRETER_PHP_UUID%/$INTERPRETER_PHP_UUID/g" ../idea-template/remote-mappings.xml | \
sed "s/%INTERPRETER_COMPOSER_UUID%/$INTERPRETER_COMPOSER_UUID/g" > "$APP_IDEA_PATH/remote-mappings.xml"
sed "s/%XDEBUG_PORT%/$XDEBUG_PORT/g" ../idea-template/workspace.xml | \
sed "s/%DOMAIN%/$DOMAIN/g" | \
sed "s/%NGINX_HTTPS_PORT%/$NGINX_HTTPS_PORT/g" | \
sed "s/%NGINX_HTTP_PORT%/$NGINX_HTTP_PORT/g" | \
sed "s/%HTTP_SERVER_UUID%/$HTTP_SERVER_UUID/g" | \
sed "s/%HTTPS_SERVER_UUID%/$HTTPS_SERVER_UUID/g" | \
sed "s/%DEPLOY_SERVER_UUID%/$DEPLOY_SERVER_UUID/g" > "$APP_IDEA_PATH/workspace.xml"

cd "$SCRIPTPATH/../src/$APP_NAME" && git init

echo -e "${GREEN}Phpstorm configuration has been setup. You can now open $SCRIPTPATH/../src/$APP_NAME into phpstorm${NC}"
