#!/bin/bash
set -e

PGHOST=${PGHOST:-localhost}
PGPORT=${PGPORT:-5432}
PGUSER=${PGUSER:-testuser}
PGPASSWORD=${PGPASSWORD:-testpass}
PGDATABASE=${PGDATABASE:-testdb}

export PGPASSWORD

duplicates=$(psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" -t -c "SELECT email, COUNT(*) FROM employees GROUP BY email HAVING COUNT(*) > 1;" | xargs)
if [ -z "$duplicates" ]; then
  echo "OK: all emails unique"
  exit 0
else
  echo "FAIL: duplicate emails found"
  exit 1
fi
