#!/bin/sh
set -e

if [ "$MIGRATIONS" != 0 ] && [ ! -z "$MIGRATIONS" ]
then
  rails db:migrate
fi

if [ "$SEED" != 0 ] && [ ! -z "$SEED" ]
then
  rails db:seed
fi

exec "$@"
