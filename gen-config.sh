#!/bin/sh
set -eo pipefail

# ANSI colour escape sequences
RED='\033[0;31m'
RESET='\033[0m'
error() { >&2 echo -e "${RED}Error: $@${RESET}"; exit 1; }

CONF_FILEBROWSER='/config/filebrowser.json'

if [ ! -e /config/*.json ]; then

    cat > "$CONF_FILEBROWSER" <<EOL
{
  "port": 8080,
  "baseURL": "",
  "address": "",
  "log": "stdout",
  "database": "/data/database.db",
  "root": "${ROOT_DIR:-.}"
}

EOL

    if [ ! -e "$CONF_FILEBROWSER" ]; then
        error "Unable to generate the configuration file $(basename $CONF_FILEBROWSER)"
    fi

fi