#!/bin/bash

# Define variables
BACKUP_DIR="./mongodb_backups"
TIMESTAMP=$(date +"%F_%H-%M")
BACKUP_PATH="$BACKUP_DIR/mongodb_backup_$TIMESTAMP"
MONGO_INITDB_ROOT_USERNAME="saul"
MONGO_INITDB_ROOT_PASSWORD="1234"
CONTAINER_NAME="mongodb"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Starting MongoDB backup..."

# Run MongoDB backup command
if docker exec "$CONTAINER_NAME" mongodump --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase admin --out /backup; then
  echo "MongoDB dump completed successfully."
else
  echo "Failed to create MongoDB dump."
  exit 1
fi

# Copy the backup from the container to the host machine
if docker cp "$CONTAINER_NAME:/backup" "$BACKUP_PATH"; then
  echo "Backup copied to host: $BACKUP_PATH"
else
  echo "Failed to copy backup to host."
  exit 1
fi

# Clean up the temporary backup inside the container
if docker exec "$CONTAINER_NAME" rm -rf /backup; then
  echo "Temporary backup inside the container cleaned up."
else
  echo "Failed to clean up temporary backup inside the container."
  exit 1
fi

echo "MongoDB backup completed: $BACKUP_PATH"
