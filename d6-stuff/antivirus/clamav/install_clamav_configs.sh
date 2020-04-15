#!/bin/bash

CONFIG_FOLDER=/usr/local/etc/clamav
CLAMD_CONFIG_FILE=$CONFIG_FOLDER/clamd.conf
FRESHCLAM_CONFIG_FILE=$CONFIG_FOLDER/freshclam.conf

RUN_FOLDER=/usr/local/var/run
LOG_FOLDER=/usr/local/var/log
DB_FOLDER=/usr/local/var/lib/clamav

CLAMD_LOG_FILE=$LOG_FOLDER/clamd.log
CLAMD_ERROR_LOG_FILE=$LOG_FOLDER/clamd.error.log
FRESHCLAM_LOG_FILE=$LOG_FOLDER/freshclam.log
FRESHCLAM_ERROR_LOG_FILE=$LOG_FOLDER/freshclam.error.log

# assumes umask 0022 (normal)
# 		NOT needed ?
sudo mkdir -p "$CONFIG_FOLDER"
# 		might be needed, depending...
sudo mkdir -p "$RUN_FOLDER"
sudo mkdir -p "$LOG_FOLDER"
# 		should be needed...
sudo mkdir -p "$DB_FOLDER"


# force the config-file patches 
DTS=$(date "+%Y%m%d-%H%M%S")
#
if [ -e "$CLAMD_CONFIG_FILE" ]; then
	sudo mv -f "$CLAMD_CONFIG_FILE" "${CLAMD_CONFIG_FILE}.${DTS}.bkp" 
fi
if [ -e "$FRESHCLAM_CONFIG_FILE" ]; then
	sudo mv -f "$FRESHCLAM_CONFIG_FILE" "${FRESHCLAM_CONFIG_FILE}.${DTS}.bkp" 
fi
#
sudo cp -p "${CLAMD_CONFIG_FILE}.sample" "$CLAMD_CONFIG_FILE"
sudo cp -p "${FRESHCLAM_CONFIG_FILE}.sample" "$FRESHCLAM_CONFIG_FILE"
sudo patch "$CLAMD_CONFIG_FILE" < clamd.patch
sudo patch "$FRESHCLAM_CONFIG_FILE" < freshclam.patch 
sudo chmod 0644 "$CLAMD_CONFIG_FILE" "$FRESHCLAM_CONFIG_FILE"

# setup log-files
[ -e "$CLAMD_LOG_FILE" ] || sudo touch "$CLAMD_LOG_FILE"
[ -e "$CLAMD_ERROR_LOG_FILE" ] || sudo touch "$CLAMD_ERROR_LOG_FILE"
[ -e "$FRESHCLAM_LOG_FILE" ] || sudo touch "$FRESHCLAM_LOG_FILE"
[ -e "$FRESHCLAM_ERROR_LOG_FILE" ] || sudo touch "$FRESHCLAM_ERROR_LOG_FILE"
sudo chmod 0644 "$CLAMD_LOG_FILE" "$CLAMD_ERROR_LOG_FILE" "$FRESHCLAM_LOG_FILE" "$FRESHCLAM_ERROR_LOG_FILE"

# fix permissions...
sudo chown -R root:wheel "$CONFIG_FOLDER"
sudo chown -R _clamav:_clamav "$DB_FOLDER"
sudo chown _clamav:_clamav "$CLAMD_LOG_FILE" "$CLAMD_ERROR_LOG_FILE" "$FRESHCLAM_LOG_FILE" "$FRESHCLAM_ERROR_LOG_FILE"

# next run install_clamav_daemons.sh (assuming plists are premade)

echo "execute install_clamav_daemons.sh now."
