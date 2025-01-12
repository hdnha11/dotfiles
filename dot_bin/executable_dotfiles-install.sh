#!/bin/bash

BLUE='\033[1;34m'
RESET='\033[0m'

function showStep() {
  echo ""
  echo -e "${BLUE}$*${RESET}"
  echo ""
}

function dotfiles {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

showStep "Clone configuration repository"
git clone --bare git@github.com:hdnha11/dotfiles.git $HOME/.dotfiles

dotfiles checkout

if [ $? = 0 ]; then
  showStep "Checked out config"
else
  showStep "Backing up pre-existing dot files"
  if [ -d .dotfiles-backup ]; then
    showStep "Remove old backup"
    rm -R .dotfiles-backup
  fi
  mkdir -p .dotfiles-backup
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi

dotfiles checkout
dotfiles config status.showUntrackedFiles no
