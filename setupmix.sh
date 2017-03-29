#!/bin/bash

#Make sure postgresql is started for database input
/etc/init.d/postgresql start

cd /magnetissimo

yes | mix deps.get
mix local.rebar --force
mix ecto.create
mix ecto.migrate


npm install
