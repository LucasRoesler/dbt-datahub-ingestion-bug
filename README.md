# Reproduction of ingestion bug with dbt

1. Setup the project using `bash setup.sh`

   This will create the required virtual env and download the citibike data.

2. Start the db using `docker-compose up -d`

   This will create a Postgres db with the citibike data.

   You can connect to it using

   ```sh
   export PGPASSWORD=example
   psql -h localhost -U demo -d citibike_tripdata -p 5432 -c "select * from trips limit 2;"
   ```

3. Run the dbt project using

   ```sh
   souce .venv/bin/activate

   dbt deps  --profiles-dir=.
   dbt run --profiles-dir=. --target dev
   dbt docs generate --profiles-dir=.
   dbt source freshness  --profiles-dir=.
   ```

   Note that the freshness test will report an error, this is expected and ok.

4. Start a local datahub instance

   ```sh
   datahub docker quickstart
   ```

5. Configure datahub:

   - Go to http://localhost:9002/settings
   - Create a Personal Access Token, copy this token

6. Run the ingestion

   ```sh
   export DATAHUB_SKIP_CONFIG=True
   export DATAHUB_GMS_HOST=http://localhost:8080
   export DATAHUB_GMS_TOKEN=eyJhbGciOiJIUzI1NiJ9.eyJhY3RvclR5cGUiOiJVU0VSIiwiYWN0b3JJZCI6ImRhdGFodWIiLCJ0eXBlIjoiUEVSU09OQUwiLCJ2ZXJzaW9uIjoiMSIsImV4cCI6MTY2MDEzODczNCwianRpIjoiNDk0NjhkN2EtZDA1ZS00ZjdjLWI5ZDEtYTYyNDhhYWU2MDU4Iiwic3ViIjoiZGF0YWh1YiIsImlzcyI6ImRhdGFodWItbWV0YWRhdGEtc2VydmljZSJ9.r1h6iILDy5SUH-bAuOpvIeNxrnPW9X3zLHlYHHw23Vc # copy your token here instead
   datahub ingest -c datahub.yaml
   ```

   And example of the ingest output has been provided in the [`ingest.output.txt`](./ingest.output.txt)

## Cleanup

1. datahub docker nuke
2. docker-compose down -v
