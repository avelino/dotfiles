# OHMYZSH Load
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
export TERM=xterm-256color

ZSH_THEME="yan"

plugins=(my-aliases)

source $ZSH/oh-my-zsh.sh

# Avelino's Custom
export KEYTIMEOUT=1
export EDITOR=e

# timezone/location
TZ='America/Sao_Paulo'; export TZ
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=C

# PATH
export PATH=$HOME/.local/bin:$PATH

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
fi
export GPG_TTY=$(tty)

eval $(keychain --agents ssh --eval id_rsa)

# Projects folder
export PROJECT_PATH=/home/project

# Go
export GOROOT=/usr/local/go
export GOPATH=/home/project
export GOCACHE=$GOPATH/cache
export PATH=/usr/local/go/bin:$PROJECT_PATH/bin:$PATH

# Python
## virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export PROJECT_HOME=$PROJECT_PATH/src
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -f /usr/local/bin/virtualenvwrapper_lazy.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh
## pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

# Node
export PATH=/usr/local/opt/node@10/bin:$PATH
export NVM_DIR="$HOME/.nvm"

# Flutter
export PATH=$PROJECT_PATH/bin/flutter/bin:$PATH

# Java
export JAVA_HOME="/usr/lib/jvm/default-java"

eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
stty sane
