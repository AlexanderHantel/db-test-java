#!/bin/bash
set -e

PGHOST=${PGHOST:-127.0.0.1}
PGPORT=${PGPORT:-5432}
PGUSER=${PGUSER:-testuser}
PGPASSWORD=${PGPASSWORD:-testpass}
PGDATABASE=${PGDATABASE:-testdb}

export PGPASSWORD

until psql -h "$PGHOST" -U "$PGUSER" -d "$PGDATABASE" -c '\q' 2>/dev/null; do
  echo "Waiting for PostgreSQL..."
  sleep 3
done

count=$(psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -t -c "SELECT COUNT(*) FROM employees;" | xargs)

if [ "$count" -eq 4 ]; then
  echo "OK: found 4 employees"
  exit 0
else
  echo "FAIL: expected 4 employees, got $count"
  exit 1
fi
