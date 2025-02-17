# My Dotfiles

This repo contains the configuration to setup my machines. This is using [Chezmoi](https://chezmoi.io), the dotfile manager to setup the install.

## Install

```shell
$ export GITHUB_USERNAME=hdnha11
$ sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

> Note that this script will install the `chezmoi` binary in the `./.local/bin` directory. Remember to change your working directory to your home directory before running the script.
