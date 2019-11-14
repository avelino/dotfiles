#!/usr/bin/env bash


if [[ "$OSTYPE" == "darwin"* ]]; then
    sh macos.install.sh
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    if [ -f /etc/debian_version ]; then
	sh debian.install.sh
    else
	echo "OS not supported!"; exit 0
    fi
else
    echo "OS not supported!"; exit 0
fi

## copy files
cp ~/dotfiles/gitconfig ~/.gitconfig
cp ~/dotfiles/tmux.conf ~/.tmux.conf
cp ~/dotfiles/zshrc ~/.zshrc
cp ~/dotfiles/fzf.zsh ~/.fzf.zsh
cp ~/dotfiles/gitignore_global ~/.gitignore_global

## emacs
git clone git://github.com/avelino/.emacs.git ~/.emacs.d

## vim
mkdir ~/.config/nvim && \
    curl 'http://vim-bootstrap.com/generate.vim' --data 'langs=javascript&langs=html&langs=python&langs=go&langs=lua&langs=rust&editor=nvim' > ~/.config/nvim/init.vim

## golang install bins
./dotfiles/golang.sh
