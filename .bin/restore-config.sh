#!/bin/bash

. ~/.bin/dotfiles-common.sh

function restoreHomebrew() {
  showStep "Restore Homebrew tap"
  brew tap $(cat $BACKUP_PATH/brew-tap-list)

  showStep "Restore Homebrew packages"
  brew install $(cat $BACKUP_PATH/brew-package-list)

  showStep "Restore Homebrew cask"
  brew cask install $(cat $BACKUP_PATH/brew-cask-list)
}

function restoreProfile() {
  showStep "Restore profile"
  cp $BACKUP_PATH/profile $HOME/.profile
}

function restoreHistory() {
  showStep "Restore history"
  cp $BACKUP_PATH/zsh_history $HOME/.zsh_history
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
while getopts ":p" opt;
do
  case "$opt" in
    p)
      if [[ $OPTARG != "" ]]; then
        BACKUP_PATH=$OPTARG
      fi
    ;;
    \?)
      printHelp
      exit 0
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

    showStep "Complete!"
  ;;
  *) printHelp;;
esac

