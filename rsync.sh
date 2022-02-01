#!/usr/bin/env bash

if [ ! -f "$JOBFILE" ]; then
  printf 'Jobber file "%s" does not exist. Check JOBFILE env variable\n' $JOBFILE
  exit 1
fi

if [ ! -f "$PRIVAT_KEY" ]; then
  printf 'SSH KEY "%s" does not exist. Check PRIVAT_KEY env variable\n' $PRIVAT_KEY
  exit 1
fi

if [ -z "$REMOTE_HOST" ]; then
  printf 'REMOTE_HOST variable is empty\n'
  exit 1
fi

if [ -z "$REMOTE_DIR" ]; then
  printf 'REMOTE_DIR variable is empty\n'
  exit 1
fi

if [ ! -d "$LOCAL_DIR" ]; then
  printf 'Dest path "$LOCAL_DIR" does not exist'
  exit 1
fi

if [ ! -z "$DELETE_REMOTE" ]; then
  RSYNC_OPTIONS="$RSYNC_OPTIONS --remove-source-files"
fi

rsync $RSYNC_OPTIONS -e "ssh -oStrictHostKeyChecking=no" $REMOTE_HOST:$REMOTE_DIR $LOCAL_DIR

exit 0
