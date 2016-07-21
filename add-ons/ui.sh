#!/bin/sh

ADDON=$1
if [[ -z $ADDON ]]
then
  echo "missing ADDON parameter: /bin/sh ui.sh [ADDON]"
  exit
fi

OPTIONAL_PATH=$2


TARGET="dsdev.lan"
#TARGET="192.168.8.128"
SSH_USER=dssadmin
DIR_UI="${ADDON}/ui/${OPTIONAL_PATH}"
REMOTE_DIR_UI="/www/pages/add-ons/${ADDON}/${OPTIONAL_PATH}"

# REMOTE_ADDON_DIR_UI="/www/pages/add-ons/"
# ssh -t -t ${SSH_USER}@${TARGET} "su -c 'chown ${SSH_USER}:${SSH_USER} ${REMOTE_ADDON_DIR_UI}'"
# ssh -t -t ${SSH_USER}@${TARGET} "su -c 'chown -R ${SSH_USER}:${SSH_USER} ${REMOTE_DIR_UI}'"

#echo ${DIR_UI}
#echo ${REMOTE_DIR_UI}
ssh ${SSH_USER}@${TARGET} "rm -rf ${REMOTE_DIR_UI}"
scp -r ${DIR_UI} ${SSH_USER}@${TARGET}:${REMOTE_DIR_UI}
