#!/bin/bash
export RESTIC_PASSWORD=${PASSWORD}
RESTIC_REPOSITORY=${REPOSITORY}
restic forget --keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune -r $RESTIC_REPOSITORY
