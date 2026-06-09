#!/usr/bin/env bash
set -euo pipefail

WORDPRESS_URL="${WORDPRESS_URL:-https://cloud1.localhost:8443/}"
PMA_URL="${PMA_URL:-https://pma.cloud1.localhost:8443/}"
DB_HOST="${DB_HOST:-127.0.0.1}"
DB_PORT="${DB_PORT:-3306}"

echo "==> Checking WordPress at ${WORDPRESS_URL}"
curl -kfsSI "${WORDPRESS_URL}" | head -n 1

echo "==> Checking phpMyAdmin at ${PMA_URL}"
curl -kfsSI "${PMA_URL}" | head -n 1

echo "==> Checking database is not publicly exposed on ${DB_HOST}:${DB_PORT}"
if command -v nc >/dev/null 2>&1; then
  if nc -z -w2 "${DB_HOST}" "${DB_PORT}"; then
    echo "FAIL: database port is reachable from here"
    exit 1
  else
    echo "OK: database port is not reachable from here"
  fi
else
  echo "Skipping nc check: netcat is not installed"
fi

echo "Smoke test passed."
