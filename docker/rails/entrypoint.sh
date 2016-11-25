#!/bin/bash
set -e

echo "Preparing environment"
bundle -j4
bin/rails db:create db:migrate db:seed

exec "$@"
