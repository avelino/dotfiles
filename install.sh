#!/usr/bin/env bash

brew bundle

## oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## copy files
cp ~/dotfiles/gitconfig ~/.gitconfig
cp ~/dotfiles/tmux.conf ~/.tmux.conf
rm ~/.zshrc && \
    cp ~/dotfiles/zshrc ~/.zshrc
cp ~/dotfiles/hyper.js ~/.hyper.js
cp ~/dotfiles/fzf.zsh ~/.fzf.zsh
cp ~/dotfiles/gitignore_global ~/.gitignore_global
cp ~/dotfiles/npmrc ~/.npmrc
cp ~/dotfiles/htoprc ~/.htoprc
cp ~/dotfiles/curlrc ~/.curlrc
cp ~/dotfiles/antigenrc ~/.antigenrc
cp -rf ~/dotfiles/clojure ~/.clojure
# cp ~/dotfiles/dotfiles/LauchAgents/*.plist ~/Library/LaunchAgents/

## emacs
git clone git://github.com/avelino/.emacs.git ~/.emacs.d

## vim
mkdir -p ~/.config/nvim && \
    curl -X POST 'https://vim-bootstrap.com/generate.vim' \
    --data 'langs=javascript&langs=typescript&langs=html&langs=python&langs=go&langs=lua&theme=dracula&editor=nvim' \
    > ~/.config/nvim/init.vim

## golang install bins
./dotfiles/golang.sh

## zsh plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
