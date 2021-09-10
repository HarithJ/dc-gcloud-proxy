#!/bin/ash

set -e

cd /var/lib/postgresql

touch .pgpass
echo "proxy:5432:${GCP_POSTGRES_DB}:${GCP_POSTGRES_USER}:${GCP_POSTGRES_PW}" >> .pgpass
echo "db:5432:${POSTGRES_DB}:${POSTGRES_USER}:${POSTGRES_PASSWORD}" >> .pgpass

chown postgres:postgres .pgpass
chmod 0600 .pgpass

until psql -h "proxy" -U "pp" -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

until psql -h "db" -U ${POSTGRES_USER} -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

pg_dump -C -O -U pp -h proxy -d pp | psql -h db -U ${POSTGRES_USER} ${POSTGRES_DB}
