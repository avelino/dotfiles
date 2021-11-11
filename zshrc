
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# OHMYZSH Load
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
export TERM=xterm-256color
export LC_ALL="en_US.UTF-8"

# ZSH_THEME="yan"
if [[ -n "$INSIDE_EMACS" ]]; then
    plugins=(my-aliases git)
    ZSH_THEME="simple"
else
    ZSH_THEME="dracula-pro"
    plugins=(my-aliases git macos zsh-autosuggestions zsh-syntax-highlighting env)
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
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
fi
export GPG_TTY=$(tty)

eval $(keychain --agents ssh --eval id_rsa)

# Projects folder
export PROJECT_PATH=~/projects

# Go
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$PROJECT_PATH
export GOCACHE=$GOPATH/cache
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH

# Python
# export PATH="/usr/local/opt/python@3.7/bin:$PATH"
export PYTHON_PATH_BIN="/usr/local/opt/python3/bin:$PATH"
export PATH="$PYTHON_PATH_BIN:$PATH"
## virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON="$PYTHON_PATH_BIN/python"

export PROJECT_HOME=$PROJECT_PATH/src
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -f /usr/local/bin/virtualenvwrapper_lazy.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh
## pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

# Node
export PATH=/usr/local/opt/node@10/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Flutter
export PATH=$PROJECT_PATH/flutter/bin:$PATH

# Java
export JAVA_HOME="/usr/local/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home"
export M2_HOME=/usr/local/opt/maven/libexec
export M2=${M2_HOME}/bin
export PATH="${PATH}:${M2_HOME}/bin:/usr/local/opt/openjdk@11/bin"

source $(brew --prefix)/share/antigen/antigen.zsh

eval "$(direnv hook zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
stty sane

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/avelino/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/avelino/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/avelino/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/avelino/google-cloud-sdk/completion.zsh.inc'; fi

cd ~/

# added by travis gem
[ ! -s /Users/avelino/.travis/travis.sh ] || source /Users/avelino/.travis/travis.sh

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
