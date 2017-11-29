#!/bin/bash

set -e

APP_USER=${APP_USER:-pyload}
APP_GROUP=${APP_GROUP:-pyload}
APP_ROOT_DIR=/app
APP_DATA_DIR=${APP_ROOT_DIR}/data
APP_TMP_DIR=${APP_DATA_DIR}/tmp
APP_CONF_DIR=${APP_DATA_DIR}/config
APP_DOWNLOAD_DIR=/download
APP_UID=${UID:-1000}
APP_GID=${GID:-1000}

if [ -f "${APP_TMP_DIR}/pyload.pid" ]; then
  rm "${APP_TMP_DIR}/pyload.pid"
fi

echo -e "${APP_USER}:x:${APP_UID}:${APP_GID}:pyload:/app:/bin/false\n" >> /etc/passwd
echo -e "${APP_GROUP}:x:${APP_GID}:appuser\n" >> /etc/group

mkdir -p "${APP_DATA_DIR}" "${APP_CONF_DIR}" "${APP_TMP_DIR}"
chown -R ${APP_USER}:${APP_GROUP} "${APP_DATA_DIR}"

mkdir -p "${APP_DOWNLOAD_DIR}"

if [ $# -lt 1 ]; then
  echo no parameters given
  exit 1
elif [ -z "$1" ]; then
  echo cannot launch empty parameter
  exit 1
elif [ -x $1 ]; then
  startme=$1
  shift 1
  echo "runnning $startme $@"
  exec $startme $@
elif [[ "$1" == "app:start" ]]; then
  exec gosu ${APP_USER} python ${APP_ROOT_DIR}/pyload/pyLoadCore.py --configdir=${APP_CONF_DIR} --pidfile=${APP_TMP_DIR}/pyload.pid
elif [[ "$1" == "app:install" ]]; then
  exec gosu ${APP_USER} python ${APP_ROOT_DIR}/pyload/pyLoadCore.py --configdir=${APP_CONF_DIR} --pidfile=${APP_TMP_DIR}/pyload.pid --setup
fi