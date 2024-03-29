#!/bin/bash

. ~/.bin/common-utils.sh

function restoreHomebrew() {
  showStep "Update the formulae and Homebrew itself"
  brew update

  showStep "Restore Homebrew tap"
  for repo in $(cat "$BACKUP_PATH/brew-tap-list"); do
    brew tap $repo
  done

  showStep "Restore Homebrew cask"
  brew install --cask $(cat "$BACKUP_PATH/brew-cask-list")

  showStep "Restore Homebrew packages"
  brew install $(cat "$BACKUP_PATH/brew-package-list")
}

function restoreProfile() {
  showStep "Restore profile"
  cp "$BACKUP_PATH/profile" $HOME/.profile
}

function restoreHistory() {
  showStep "Restore history"
  cp "$BACKUP_PATH/zsh_history" $HOME/.zsh_history
}

function restoreSSH() {
  showStep "Restore ssh"
  cp -R "$BACKUP_PATH/ssh" $HOME/.ssh
}

function printHelp() {
  echo ""
  echo -e "${RESET}Usage: restore-config.sh [OPTIONS]"
  echo ""
  echo -e "${RESET}Options:"
  echo -e "${GREEN}-p ${RESET}Backup path" | indent
  echo ""
}

# Print the header information for execution
function printHeader() {
  echo -e "${YELLOW}Restore macOS configuration files"
  echo ""
}

# Get the command line options
while getopts ":p:" opt; do
  case $opt in
    p)
      if [[ $OPTARG != "" ]]; then
        BACKUP_PATH=$OPTARG
      fi
    ;;
    \?)
      printHelp
      exit 0
    ;;
    :)
      echo -e "${RED}Option -$OPTARG requires an argument." >&2
      exit 1
    ;;
  esac
done

printHeader

echo "Parameters:"
echo -e "${PURPLE}Backup path ${GREEN}$BACKUP_PATH ${RESET}" | indent
echo ""
read -p "$(echo -e "${RED}Continue [y/N]? ${RESET}")" choice

case "$choice" in
  y|Y|yes|Yes|YES)
    getCurrent

    restoreHomebrew
    restoreProfile
    restoreHistory
    restoreSSH

    showStep "Complete!"
  ;;
  *) printHelp;;
esac

