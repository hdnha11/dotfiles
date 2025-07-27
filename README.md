# My Dotfiles

This repo contains the configuration to setup my machines. This is using [Chezmoi](https://chezmoi.io), the dotfile manager to setup the install.

## Prerequisites

Before running the install script, make sure you have the following installed:

- **Xcode Command Line Tools**:
  ```shell
  xcode-select --install
  ```

- **Rosetta 2** (for Apple Silicon):
  ```shell
  sudo softwareupdate --install-rosetta --agree-to-license
  ```

## Install

```shell
$ export GITHUB_USERNAME=hdnha11
$ sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

> Note that this script will install the `chezmoi` binary in the `./.local/bin` directory. Remember to change your working directory to your home directory before running the script.
