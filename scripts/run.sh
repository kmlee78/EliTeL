#!/bin/bash

set -ex

if [ $# -lt 1 ]; then
  echo "Error: No argument provided."
  exit 1
fi

ARGS=$1
docker compose -f docker-compose.yaml build
docker compose -f docker-compose.yaml up $ARGS