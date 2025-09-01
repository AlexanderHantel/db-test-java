#!/bin/bash
set -e

PGHOST=${PGHOST:-localhost}
PGPORT=${PGPORT:-5432}
PGUSER=${PGUSER:-testuser}
PGPASSWORD=${PGPASSWORD:-testpass}
PGDATABASE=${PGDATABASE:-testdb}

export PGPASSWORD

invalid=$(psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -t -c "SELECT COUNT(*) FROM employees WHERE email NOT LIKE '%@%';" | xargs)
if [ "$invalid" -eq 0 ]; then
  echo "OK: all emails have @"
  exit 0
else
  echo "FAIL: found $invalid invalid emails"
  exit 1
fi
