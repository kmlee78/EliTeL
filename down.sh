#!/bin/bash

ARGS=$@
docker compose -f docker-compose.yaml down $ARGS