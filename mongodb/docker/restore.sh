#!/bin/bash

# Define variables
BACKUP_DIR="./data"
MONGO_INITDB_ROOT_USERNAME="root"
MONGO_INITDB_ROOT_PASSWORD="password"
CONTAINER_NAME="mongodb"

# Find the latest backup directory
LATEST_BACKUP=$(ls -td ${BACKUP_DIR}/mongodb_backup_* | head -1)

if [ -z "$LATEST_BACKUP" ]; then
  echo "No backup found in $BACKUP_DIR"
  exit 1
fi

echo "Latest backup found: $LATEST_BACKUP"

# Copy the latest backup to the MongoDB container
if docker cp "$LATEST_BACKUP" "$CONTAINER_NAME:/backup"; then
  echo "Backup copied to container."
else
  echo "Failed to copy backup to container."
  exit 1
fi

# Restore the backup inside the container
if docker exec "$CONTAINER_NAME" mongorestore --username $MONGO_INITDB_ROOT_USERNAME --password $MONGO_INITDB_ROOT_PASSWORD --authenticationDatabase admin --drop /backup; then
  echo "MongoDB restore completed successfully."
else
  echo "Failed to restore MongoDB backup."
  exit 1
fi

# Clean up the temporary backup inside the container
if docker exec "$CONTAINER_NAME" rm -rf /backup; then
  echo "Temporary backup inside the container cleaned up."
else
  echo "Failed to clean up temporary backup inside the container."
  exit 1
fi

echo "MongoDB restore completed from backup: $LATEST_BACKUP"
