# My Dotfiles

## Requirements

- Git
- cURL

## Install

Install config tracking in your $HOME by running:

```sh
$ curl -Lks git.io/vHjm6 | /bin/bash
```

The expanded url is at:

https://raw.githubusercontent.com/hdnha11/dotfiles/master/.bin/dotfiles-install.sh

## Screenshots

### Vim

![Vim Screenshot](https://user-images.githubusercontent.com/1773032/37331937-f4e1cbb6-26d7-11e8-8b13-7706066c5849.png)

> Font: 16pt Fira Code\
> Non-ASCII Font: 17pt DejaVu Sans Mono for Powerline

### Tmux

![Tmux Screenshot](https://user-images.githubusercontent.com/1773032/37331963-053cb30e-26d8-11e8-8b5a-55185a0a482c.png)

> `$ brew install reattach-to-user-namespace`\
> **For iTerm2 3.1.6+** Disable *Use Unicode Version 9 Widths* in *Preferences/Profiles/Text*

### Hammerspoon

#### Application Mode

![App Switcher](https://user-images.githubusercontent.com/1773032/37331991-131d33f4-26d8-11e8-9256-f2096414b07d.png)

#### Window Mode

![Window Management](https://user-images.githubusercontent.com/1773032/37332091-4d74230a-26d8-11e8-9040-065049360dea.png)

## Set up a new Mac

```sh
# Install Homebrew (https://brew.sh/)
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Git, cURL
$ brew install git curl

# Grab backup folder from Dropbox

# Set up github ssh key (from backup)

# Get dotfiles
$ curl -Lks git.io/vHjm6 | /bin/bash

# Restore backup
$ .bin/restore-config.sh -p [backup-path]

# Install nvm (https://github.com/creationix/nvm#install-script)
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install Oh My Zsh (https://github.com/robbyrussell/oh-my-zsh)
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Reset dotfiles
$ dotfiles checkout .

# Install zsh-syntax-highlighting (https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install zsh-autosuggestions (https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Install vim-plug (https://github.com/junegunn/vim-plug)
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Open Vim and run :PlugInstall
```
