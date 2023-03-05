#!/bin/bash

set -ex

ARGS=$@
docker compose -f docker-compose.yaml build
docker compose -f docker-compose.yaml up $ARGS