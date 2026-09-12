#!/bin/bash

# PostgreSQL backup configuration
CONTAINER="web_database"
DATABASE="appdb"
DB_USER="appuser"
BACKUP_DIR="/var/backups/db"

# Timestamp
TIMESTAMP=$(date '+%Y%m%d')

# Backup file
BACKUP_FILE="${BACKUP_DIR}/db_backup_${TIMESTAMP}.sql.gz"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Starting PostgreSQL backup..."

# Create database dump and compress it
docker exec "$CONTAINER" pg_dump -U "$DB_USER" "$DATABASE" | gzip > "$BACKUP_FILE"

# Check whether backup was successful
if [ $? -eq 0 ]; then
    echo "[SUCCESS] Database backup created: $BACKUP_FILE"
else
    echo "[ERROR] Database backup failed"
    rm -f "$BACKUP_FILE"
    exit 1
fi
