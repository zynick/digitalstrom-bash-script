#!/bin/sh

ADDON=$1
if [[ -z $ADDON ]]
then
  echo "missing ADDON parameter: /bin/sh copy.sh [ADDON]"
  exit
fi

TARGET="dsdev.lan"
#TARGET="192.168.8.128"
SSH_USER=dssadmin

REMOTE_ADDON_DIR_UI="/www/pages/add-ons/"
REMOTE_ADDON_DIR_CONF="/usr/share/dss/data/subscriptions.d/"
REMOTE_ADDON_DIR_SCRIPTS="/usr/share/dss/add-ons/"

REMOTE_DIR_UI="/www/pages/add-ons/${ADDON}/"
REMOTE_CONF_XML="/usr/share/dss/data/subscriptions.d/${ADDON}.xml"
REMOTE_DIR_SCRIPTS="/usr/share/dss/add-ons/${ADDON}/"

echo "[copy.sh] change directory ownership..."
ssh -t -t ${SSH_USER}@${TARGET} "su -c 'chown ${SSH_USER}:${SSH_USER} ${REMOTE_ADDON_DIR_UI}; chown ${SSH_USER}:${SSH_USER} ${REMOTE_ADDON_DIR_CONF}; chown ${SSH_USER}:${SSH_USER} ${REMOTE_ADDON_DIR_SCRIPTS}'"
ssh -t -t ${SSH_USER}@${TARGET} "su -c 'chown -R ${SSH_USER}:${SSH_USER} ${REMOTE_DIR_UI}; chown -R ${SSH_USER}:${SSH_USER} ${REMOTE_CONF_XML}; chown -R ${SSH_USER}:${SSH_USER} ${REMOTE_DIR_SCRIPTS}'"

echo "\n[copy.sh] remove addon..."
dss-remove-addon ${ADDON} ${TARGET} ${SSH_USER}

echo "\n[copy.sh] install addon & restart server..."
dss-install-addon ${ADDON} ${TARGET} ${SSH_USER}

echo "\n[copy.sh] done."
