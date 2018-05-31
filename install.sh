#!/usr/bin/env bash

## install packages for debian
sudo apt-key add debian.repokeys
sudo cp debian.sources /etc/apt/sources.list && sudo cp debian.sources.list.d/* /etc/apt/sources.list.d/
sudo apt update && sudo apt upgrade && sudo apt-get install dselect
sudo dselect update && sudo dpkg --set-selections < debian.packages && sudo apt-get dselect-upgrade -y

## copy files
ln -s gitconfig ~/.gitconfig
ln -s tmux.conf ~/.tmux.conf
ln -s zshrc ~/.zshrc

## emacs
git clone git://github.com/avelino/.emacs.git ~/.emacs.d

## vim
curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=javascript&langs=html&langs=python&langs=go&langs=lua&langs=rust&editor=vim' > ~/.vimrc

## golang install bins
./golang.sh
