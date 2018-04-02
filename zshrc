# OHMYZSH Load
export ZSH=/home/avelino/.oh-my-zsh

ZSH_THEME="lambda"

plugins=(
    git
    zsh-syntax-highlighting
    sudo
    command-not-found
    history
)

source $ZSH/oh-my-zsh.sh

# Avelino's Custom
export KEYTIMEOUT=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias G=g
alias e="emacsclient -nw --socket-name avelino"
alias vi="emacsclient -nw --socket-name avelino"
# alias es="emacs --eval '(setq server-name \"avelino\")' --daemon --with-x-toolkit=lucid"
alias es="emacs --eval '(setq server-name \"avelino\")' --daemon"
alias esk="killall emacs"
alias emacs="emacs -nw"
alias htop="TERM=tmux htop"
alias gl="git log --graph --pretty='format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset'"

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

eval $(keychain --agents ssh --eval id_rsa)

# Projects folder
export PROJECT_PATH=$HOME

# GOLANG
export GOPATH=$PROJECT_PATH
export GOCACHE=$PROJECT_PATH/cache

# Python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export PROJECT_HOME=$PROJECT_PATH/src
export VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper.sh
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

# PATH
export PATH=$PROJECT_PATH/bin:$HOME/.local/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

stty sane
