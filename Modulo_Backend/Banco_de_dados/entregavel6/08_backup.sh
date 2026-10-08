#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

DB_NAME="${PGDATABASE:-sistema_academico}"
DB_USER="${PGUSER:-postgres}"
DB_HOST="${PGHOST:-localhost}"
DB_PORT="${PGPORT:-5432}"
BACKUP_DIR="${BACKUP_DIR:-./backups}"
backup_file=""

handle_error() {
    status=$?
    if [[ -n "$backup_file" && -f "$backup_file" ]]; then
        rm -f "$backup_file"
    fi
    printf 'Falha ao criar o backup de %s.\n' "$DB_NAME" >&2
    exit "$status"
}

trap handle_error ERR

command -v pg_dump >/dev/null
command -v find >/dev/null

mkdir -p "$BACKUP_DIR"
timestamp="$(date '+%Y%m%d_%H%M%S')"
backup_file="${BACKUP_DIR}/${DB_NAME}_${timestamp}.dump"

pg_dump \
    --format=custom \
    --no-owner \
    --no-privileges \
    --host="$DB_HOST" \
    --port="$DB_PORT" \
    --username="$DB_USER" \
    --file="$backup_file" \
    "$DB_NAME"

test -s "$backup_file"
trap - ERR

find "$BACKUP_DIR" \
    -type f \
    -name "${DB_NAME}_*.dump" \
    -mmin +43200 \
    -delete

printf 'Backup criado: %s\n' "$backup_file"