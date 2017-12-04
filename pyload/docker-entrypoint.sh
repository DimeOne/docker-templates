#!/bin/bash

set -e

APP_ROOT_DIR=/app
APP_DATA_DIR=${APP_ROOT_DIR}/data
APP_TMP_DIR=${APP_DATA_DIR}/tmp
APP_CONF_DIR=${APP_DATA_DIR}/config
APP_DOWNLOAD_DIR=/download

if [ -f "${APP_TMP_DIR}/pyload.pid" ]; then
  rm "${APP_TMP_DIR}/pyload.pid"
fi

mkdir -p "${APP_DATA_DIR}" "${APP_CONF_DIR}" "${APP_TMP_DIR}" "${APP_DOWNLOAD_DIR}"

if [[ "$1" == "app:start" ]]; then
  exec python ${APP_ROOT_DIR}/pyload/pyLoadCore.py --configdir=${APP_CONF_DIR} --pidfile=${APP_TMP_DIR}/pyload.pid
elif [[ "$1" == "app:install" ]]; then
  exec python ${APP_ROOT_DIR}/pyload/pyLoadCore.py --configdir=${APP_CONF_DIR} --pidfile=${APP_TMP_DIR}/pyload.pid --setup
else 
  startme=$1
  shift 1
  echo "runnning $startme $@"
  exec $startme $@
fi