#!/usr/bin/env bash

set -e
# A simple helper to run docker-compose exec on running services

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTPATH/../"

# Allow word splitting for 1st argument
# That way we can add options to our exec (ex: ./docker-compose-exec "-u 0:0 wordpress" /bin/bash)
{
  docker-compose exec $@
} || { # exec command failed, try to use run command instead
  echo "trying run command into a new one"
  docker-compose run $@
}