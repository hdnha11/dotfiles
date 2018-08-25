#!/bin/bash

YELLOW='\033[1;33m'
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
RESET='\033[0m'

BACKUP_PATH="${HOME}/Dropbox/Backup/macOS"

# Indent text on echo
function indent() {
  c='s/^/    /'
  case $(uname) in
    Darwin) sed -l "$c";;
    *)      sed -u "$c";;
  esac
}

# Displays where we are, uses the indent function (above) to indent each line
function showStep() {
  echo ""
  echo -e "${BLUE}$*${RESET}"
  echo ""
}

# Grab the current directory
function getCurrent() {
  showStep "Getting current directory"
  DIR="$(pwd)"
  echo "Current dir: ${DIR}"
  THIS_SCRIPT=`basename "$0"`
  showStep "Running '${THIS_SCRIPT}'"
}
