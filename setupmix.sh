#!/bin/bash

cd /magnetissimo

yes | mix deps.get

yes | mix ecto.create
mix ecto.migrate


npm install
