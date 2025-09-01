#!/bin/bash
set -e

HOST="${DB_HOST:-db}"
PORT="${DB_PORT:-5432}"
USER="${DB_USER:-testuser}"
DB_NAME="${DB_NAME:-testdb}"

echo "[entrypoint] Waiting for PostgreSQL at ${HOST}:${PORT} as ${USER} ..."

RETRIES=60
n=0
until pg_isready -h "$HOST" -p "$PORT" -U "$USER" -d "$DB_NAME" >/dev/null 2>&1; do
  n=$((n+1))
  if [ $n -ge $RETRIES ]; then
    echo "[entrypoint] Timeout waiting for PostgreSQL" >&2
    exit 1
  fi
  echo "[entrypoint] pg not ready yet. sleeping 1s ($n/$RETRIES)"
  sleep 1
done

echo "[entrypoint] PostgreSQL is ready - running mvn test"
mvn -B test
EXIT_CODE=$?
echo "[entrypoint] mvn finished with code $EXIT_CODE"
exit $EXIT_CODE
