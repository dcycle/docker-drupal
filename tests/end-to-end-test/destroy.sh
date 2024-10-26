#!/bin/bash
#
# Destroy an environment.
#
set -e

docker compose down -v
rm .env
