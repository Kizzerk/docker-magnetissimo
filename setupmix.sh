#!/bin/bash

#Make sure postgresql is started for database input
/etc/init.d/postgresql start

cd /magnetissimo

yes | mix deps.get
mix local.rebar --force
mix ecto.create
mix deps.clean postgrex
mix deps.compile postgrex
mix deps.update postgrex
mix ecto.migrate



