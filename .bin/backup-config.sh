#!/bin/bash

. ~/.bin/common-utils.sh

REMOVE_OLD_BACKUP=false

function removeOldBackup() {
  if [ -d $BACKUP_PATH ]; then
    showStep "Remove old backup $BACKUP_PATH"
    rm -R "$BACKUP_PATH"
  fi
}

function createBackupDir() {
  if [ ! -d $BACKUP_PATH ]; then
    showStep "Create backup directory $BACKUP_PATH"
    mkdir -p $BACKUP_PATH
  fi
}

function backupHomebrew() {
  showStep "Backup Homebrew tap"
  brew tap > $BACKUP_PATH/brew-tap-list

  showStep "Backup Homebrew cask"
  brew cask list > $BACKUP_PATH/brew-cask-list

  showStep "Backup Homebrew packages"
  brew list > $BACKUP_PATH/brew-package-list
}

function backupProfile() {
  showStep "Backup profile"
  cp $HOME/.profile $BACKUP_PATH/profile
}

function backupHistory() {
  showStep "Backup history"
  cp $HOME/.zsh_history $BACKUP_PATH/zsh_history
}

function backupSSH() {
  showStep "Backup ssh"
  cp -R $HOME/.ssh $BACKUP_PATH/ssh
}

function printHelp() {
  echo ""
  echo -e "${RESET}Usage: backup-config.sh [OPTIONS]"
  echo ""
  echo -e "${RESET}Options:"
  echo -e "${GREEN}-p ${RESET}Backup path" | indent
  echo -e "${GREEN}-c ${RESET}Remove old backup" | indent
  echo ""
}

# Print the header information for execution
function printHeader() {
  echo -e "${YELLOW}Backup macOS configuration files"
  echo ""
}

# Get the command line options
while getopts ":p:c" opt; do
  case $opt in
    p)
      if [[ $OPTARG != "" ]]; then
        BACKUP_PATH=$OPTARG
      fi
    ;;
    c) REMOVE_OLD_BACKUP=true;;
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
echo -e "${PURPLE}Remove old backup ${GREEN}${REMOVE_OLD_BACKUP} ${RESET}" | indent
echo ""
read -p "$(echo -e "${RED}Continue [y/N]? ${RESET}")" choice

case "$choice" in
  y|Y|yes|Yes|YES)
    getCurrent

    if [ "$REMOVE_OLD_BACKUP" = true ]; then
      removeOldBackup
    fi

    createBackupDir
    backupHomebrew
    backupProfile
    backupHistory
    backupSSH

    showStep "Complete!"
  ;;
  *) printHelp;;
esac

