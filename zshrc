# OHMYZSH Load
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
export TERM=xterm-256color
export LC_ALL="en_US.UTF-8"
export ZSH_DISABLE_COMPFIX="true"

ZSH_THEME="dracula-pro"
plugins=(my-aliases git macos env zsh-syntax-highlighting zsh-autosuggestions)
if [[ -n "$INSIDE_EMACS" ]]; then
    plugins=(my-aliases git)
    ZSH_THEME="simple"
fi

source $ZSH/oh-my-zsh.sh

# Avelino's Custom
export KEYTIMEOUT=1
export EDITOR="code --wait"

# timezone/location
TZ='America/Sao_Paulo'; export TZ
export LANG=en_US.UTF-8
export LC_ALL=

# PATH
export HOMEBREW_PREFIX=/opt/homebrew
export PATH=$HOME/.local/bin:$HOMEBREW_PREFIX/bin:/usr/local/bin:$PATH

if ! [[ -n "$(pgrep gpg-agent)" ]]; then
    eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
    export SSH_AUTH_SOCK=/Users/avelino/.gnupg/S.gpg-agent.ssh
fi
export GPG_TTY=$(tty)

eval $(keychain --agents ssh --eval id_rsa)

# Projects folder
export PROJECT_PATH=~/projects

# Go
export GOROOT=$HOMEBREW_PREFIX/opt/go/libexec
export GOPATH=$PROJECT_PATH
export GOCACHE=$GOPATH/cache
export PATH=$HOMEBREW_PREFIX/opt/go/bin:$GOPATH/bin:$PATH

# Python
export PYTHON_PATH_BIN="$HOMEBREW_PREFIX/opt/python@3/bin:$PATH"
export PATH=$PYTHON_PATH_BIN:$PATH
## virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON="$PYTHON_PATH_BIN/python"
export PROJECT_HOME=$PROJECT_PATH/src
export VIRTUALENVWRAPPER_SCRIPT=$HOMEBREW_PREFIX/bin/virtualenvwrapper.sh
[ -f $HOMEBREW_PREFIX/bin/virtualenvwrapper_lazy.sh ] && source $HOMEBREW_PREFIX/bin/virtualenvwrapper_lazy.sh
## pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

# Node
export PATH=$HOMEBREW_PREFIX/opt/node/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Flutter
export PATH=$PROJECT_PATH/flutter/bin:$PATH

# Java
export JAVA_HOME="$HOMEBREW_PREFIX/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
export M2_HOME=$HOMEBREW_PREFIX/opt/maven/libexec
export M2=${M2_HOME}/bin
export PATH=$PATH:$M2_HOME/bin:$HOMEBREW_PREFIX/opt/openjdk/bin

eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
stty sane

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi
cd ~/
