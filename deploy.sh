#!/bin/bash

export MIX_ENV=prod
export PORT=4271
export SECRET_KEY_BASE=insecure
export DATABASE_URL=ecto://"events":"oud0aeCh1ahz"@localhost/events

echo "Building..."

mix deps.get --only prod
mix compile

# Taken from CS4550 lecture notes
# Author: Nat Tuck
# Attribution: https://github.com/NatTuck/scratch-2021-01/blob/master/4550/0212/hangman/deploy.sh
CFGD=$(readlink -f ~/.config/events)

if [ ! -d "$CFGD" ]; then
    mkdir -p "$CFGD"
fi

if [ ! -e "$CFGD/base" ]; then
    mix phx.gen.secret > "$CFGD/base"
fi

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

echo "Generating release..."
mix release

echo "Starting app..."

PROD=t ./start.sh
