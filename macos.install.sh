#!/usr/bin/env bash

## install packages for macOS

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd ~/dotfiles
brew bundle