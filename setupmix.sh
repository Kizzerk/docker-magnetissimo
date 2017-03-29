#!/bin/bash

cd /magnetissimo

yes | mix deps.get
mix local.rebar --force
mix ecto.create
mix ecto.migrate


npm install
