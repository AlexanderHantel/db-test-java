#!/bin/bash
set -e

PGHOST=${PGHOST:-localhost}
PGPORT=${PGPORT:-5432}
PGUSER=${PGUSER:-testuser}
PGPASSWORD=${PGPASSWORD:-testpass}
PGDATABASE=${PGDATABASE:-testdb}

export PGPASSWORD

nulls=$(psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -t -c "SELECT COUNT(*) FROM employees WHERE name IS NULL;" | xargs)
if [ "$nulls" -eq 0 ]; then
  echo "OK: no null names"
  exit 0
else
  echo "FAIL: found $nulls null names"
  exit 1
fi
