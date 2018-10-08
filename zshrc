# OHMYZSH Load
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
export TERM=xterm-256color

ZSH_THEME="yan"

plugins=(my-aliases)

source $ZSH/oh-my-zsh.sh

# Avelino's Custom
export KEYTIMEOUT=1

# timezone/location
TZ='America/Sao_Paulo'; export TZ
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
export PROJECT_PATH=$HOME

# Go
export GOPATH=$PROJECT_PATH
export GOCACHE=$PROJECT_PATH/cache
export PATH=/usr/local/go/bin:$PROJECT_PATH/bin:$PATH

# Python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export PROJECT_HOME=$PROJECT_PATH/src
export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
[ -f /usr/local/bin/virtualenvwrapper_lazy.sh ] && source /usr/local/bin/virtualenvwrapper_lazy.sh

# Java
export JAVA_HOME="/usr/lib/jvm/default-java"

[ -f ~/dotfiles/fzf.zsh ] && source ~/dotfiles/fzf.zsh
stty sane

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/avelino/.sdkman"
[[ -s "/home/avelino/.sdkman/bin/sdkman-init.sh" ]] && source "/home/avelino/.sdkman/bin/sdkman-init.sh"
