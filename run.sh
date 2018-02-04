#!/bin/sh
set -e
echo "SHSHSHSHSHSHSHSHSHSHSHSHS"

if [ "$CREATE_DB" != 0 ] && [ ! -z "$CREATE_DB" ]
then
  echo "CREATE_DB CREATE_DB CREATE_DB CREATE_DB CREATE_DB !!!!!!"
  rails db:create
fi

if [ "$MIGRATIONS" != 0 ] && [ ! -z "$MIGRATIONS" ]
then
  echo "MIGRATIONS MIGRATIONS MIGRATIONS MIGRATIONS MIGRATIONS !!!!!!"
  rails db:migrate
fi

if [ "$SEED" != 0 ] && [ ! -z "$SEED" ]
then
  echo "SEED SEED SEED SEED SEED !!!!!!"
  rails db:seed
fi

exec "$@"
