#!/bin/bash

# Set the restic password
export RESTIC_PASSWORD=${PASSWORD}

# Define the local backup repository
RESTIC_REPOSITORY=${TO_LOCATION}
BACKUP_SOURCE=${FROM_LOCATION}

# Ensure the backup directory exists
mkdir -p $RESTIC_REPOSITORY

# Run the backup, excluding unwanted directories
/usr/local/bin/restic -r $RESTIC_REPOSITORY backup $BACKUP_SOURCE --exclude ${EXCLUDE_1} --exclude ${EXCLUDE_2}
