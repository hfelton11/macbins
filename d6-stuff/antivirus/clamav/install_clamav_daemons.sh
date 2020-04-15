#!/bin/bash

DAEMON_FOLDER=/Library/LaunchDaemons
CLAMD_DAEMON_NAME=clamav.clamd
CLAMD_DAEMON_FILE=$DAEMON_FOLDER/$CLAMD_DAEMON_NAME.plist
FRESHCLAM_DAEMON_NAME=clamav.freshclam
FRESHCLAM_DAEMON_FILE=$DAEMON_FOLDER/$FRESHCLAM_DAEMON_NAME.plist

# unlikely ?
[ -d "$DAEMON_FOLDER" ] || sudo mkdir -p "$DAEMON_FOLDER"

sudo cp -p "${CLAMD_DAEMON_NAME}.plist" "$CLAMD_DAEMON_FILE"
sudo cp -p "${FRESHCLAM_DAEMON_NAME}.plist" "$FRESHCLAM_DAEMON_FILE"
sudo chown root:wheel "$CLAMD_DAEMON_FILE" "$FRESHCLAM_DAEMON_FILE"
sudo chmod 0644 "$CLAMD_DAEMON_FILE" "$FRESHCLAM_DAEMON_FILE"
sudo launchctl load "$CLAMD_DAEMON_FILE" "$FRESHCLAM_DAEMON_FILE"
