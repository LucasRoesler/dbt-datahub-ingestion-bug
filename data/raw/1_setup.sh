#!/bin/bash

set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE TABLE IF NOT EXISTS trips (
        ride_id varchar(16)  PRIMARY KEY,
        rideable_type text,
        started_at timestamp without time zone,
        ended_at timestamp without time zone,
        start_station_name text,
        start_station_id text,
        end_station_name text,
        end_station_id text,
        start_lat float,
        start_lng float,
        end_lat float,
        end_lng float,
        member_casual text
    );
    CREATE INDEX IF NOT EXISTS idx_start_station ON trips USING hash (start_station_id);
    CREATE INDEX IF NOT EXISTS idx_end_station ON trips USING hash (end_station_id);
    CREATE INDEX IF NOT EXISTS idx_member_type ON trips USING hash (member_casual);
    CREATE INDEX IF NOT EXISTS idx_ride_type ON trips USING hash (rideable_type);
EOSQL
