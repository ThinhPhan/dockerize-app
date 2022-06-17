#!/usr/bin/env bash
docker run \
  --name db \
  -d \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=password \
  -e POSTGRES_USER=root \
  -e POSTGRES_DB=studentjob-dev \
  -e PGDATA=/var/lib/postgresql/data/pgdata \
  -v ~/Documents/docker-data/studentjob-db-data=/var/lib/postgresql/data \
  postgres:9.6
