#!/usr/bin/env bash

if [[$(uname) == 'Darwin']]; then
    bash ~/dotfiles/macos/install.sh
fi

## copy files
cp ~/dotfiles/gitconfig ~/.gitconfig

## tmux config
mkdir -p ~/.tmux/plugins && \
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && \
    cp ~/dotfiles/tmux.conf ~/.tmux.conf

## emacs config
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d && \
    ln -s ~/dotfiles/doom.d ~/.doom.d && \
    ~/.emacs.d/bin/doom env && \
    ~/.emacs.d/bin/doom install

## fish shell
rm -rf ~/.config/fish && \
	ln -s ~/dotfiles/fish ~/.config/fish

ln -s ~/dotfiles/rio ~/.config/rio
ln -s ~/dotfiles/helix ~/.config/helix
cp ~/dotfiles/gitignore_global ~/.gitignore_global
cp ~/dotfiles/npmrc ~/.npmrc
cp ~/dotfiles/htoprc ~/.htoprc
cp ~/dotfiles/curlrc ~/.curlrc
cp ~/dotfiles/antigenrc ~/.antigenrc
git clone git@github.com:practicalli/clojure-deps-edn.git ~/.clojure
cp -rf ~/dotfiles/gh ~/.config/gh
ln -s ~/dotfiles/skhdrc ~/.skhdrc
ln -s ~/dotfiles/yabairc ~/.yabairc
# cp ~/dotfiles/dotfiles/LauchAgents/*.plist ~/Library/LaunchAgents/

## vim config (by vim-bootstrap.com)
mkdir -p ~/.config/nvim && \
    curl -X POST 'https://vim-bootstrap.com/generate.vim' \
    --data 'langs=javascript&langs=typescript&langs=html&langs=python&langs=go&langs=lua&theme=dracula&editor=nvim' \
    > ~/.config/nvim/init.vim

## golang install bins
~/dotfiles/golang.sh
