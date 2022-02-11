#!/bin/bash

set -e
echo "COPY trips FROM '/docker-entrypoint-initdb.d/$DATAFILE' CSV HEADER;" |
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB"
