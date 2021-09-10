# Purpose

The purpose of this repository is to enable us to fetch data from a GCP database through SQL Proxy and insert it into local database running in Docker Compose.


# Pre-requisite

1. You will need to copy the environment variables in `.env.example` file to `.env` file and fill them with appropriate values.

2. You will need a service account file under the `secrets` folder named `sql-access.json`. This service account should have permissions to access the database in GCP.


# Running

To start the process, you can run this single command:
```
docker-compose up
```

# Stopping

TO stop and remove the containers run:
```
docker-compose down
```

TO remove the volumes as well run:
```
docker-compose down -v
```
