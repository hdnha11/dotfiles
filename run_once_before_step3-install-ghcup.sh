#!/bin/bash

[ ! -d "$HOME/.ghcup" ] && curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

echo "GHCup installation complete."
