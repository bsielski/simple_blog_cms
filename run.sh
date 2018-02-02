#!/bin/sh
set -e

if [ "$MIGRATIONS" != 0 ] && [ ! -z "$MIGRATIONS" ]
then
  rails db:migrate
#   echo migrations was 0
#   MIGRATIONS=1
#   echo migrations is now:
#   echo $MIGRATIONS
# else
#   echo migrations is not 0
#   echo is:
#   echo $MIGRATIONS
fi

if [ "$SEED" != 0 ] && [ ! -z "$SEED" ]
then
  rails db:seed
  # SEED=1
  # echo seed is:
  # echo $SEED
# else
#   echo seed is not 0
#   echo is:
#   echo $SEED
fi

exec "$@"
