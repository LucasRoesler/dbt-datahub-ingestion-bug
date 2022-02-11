#!/bin/bash

if [[ ! -d .venv ]]; then
    echo "setup python env"
    python3 -m venv .venv
    source .venv/bin/activate

    pip install dbt-core dbt-postgres
    pip install 'acryl-datahub[postgres,datahub-rest]'
fi

if [[ ! -f data/raw/JC-202110-citibike-tripdata.csv ]]; then
    echo "download citibike data"
    curl -o JC-202110-citibike-tripdata.csv.zip -sL https://s3.amazonaws.com/tripdata/JC-202110-citibike-tripdata.csv.zip
    unzip -o JC-202110-citibike-tripdata.csv.zip -x '__MACOSX/*' -d data/raw
fi

echo "done, run: "
echo ""
echo "souce .venv/bin/activate"
echo ""
