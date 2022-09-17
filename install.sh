#!/usr/bin/env bash

## copy files
cp ~/dotfiles/gitconfig ~/.gitconfig
cp ~/dotfiles/tmux.conf ~/.tmux.conf
rm -rf ~/.config/fish && \
	ln -s ~/dotfiles/fish ~/.config/fish
cp ~/dotfiles/hyper.js ~/.hyper.js
# cp ~/dotfiles/fzf.zsh ~/.fzf.zsh
cp ~/dotfiles/gitignore_global ~/.gitignore_global
cp ~/dotfiles/npmrc ~/.npmrc
cp ~/dotfiles/htoprc ~/.htoprc
cp ~/dotfiles/curlrc ~/.curlrc
cp ~/dotfiles/antigenrc ~/.antigenrc
git clone git@github.com:practicalli/clojure-deps-edn.git ~/.clojure
cp -rf ~/dotfiles/gh ~/.config/gh
# cp ~/dotfiles/dotfiles/LauchAgents/*.plist ~/Library/LaunchAgents/

## emacs
# git clone git://github.com/avelino/.emacs.git ~/.emacs.d

## vim
mkdir -p ~/.config/nvim && \
    curl -X POST 'https://vim-bootstrap.com/generate.vim' \
    --data 'langs=javascript&langs=typescript&langs=html&langs=python&langs=go&langs=lua&theme=dracula&editor=nvim' \
    > ~/.config/nvim/init.vim

## golang install bins
./dotfiles/golang.sh
