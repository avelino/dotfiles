# OHMYZSH Load
export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/dotfiles/zsh_custom
export TERM=xterm-256color

ZSH_THEME="yan"

plugins=()

source $ZSH/oh-my-zsh.sh

# Avelino's Custom
export KEYTIMEOUT=1

TZ='America/Sao_Paulo'; export TZ
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias g=git
alias G=g
alias e="emacsclient -nw --socket-name avelino"
alias vi="emacsclient -nw --socket-name avelino"
# alias es="emacs --eval '(setq server-name \"avelino\")' --daemon --with-x-toolkit=lucid"
alias es="emacs --eval '(setq server-name \"avelino\")' --daemon"
alias esk="killall emacs"
alias emacs="emacs -nw"
# alias htop="TERM=tmux htop"
alias gl="git log --graph --pretty='format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset'"

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

# GOLANG
export GOPATH=$PROJECT_PATH
export GOCACHE=$PROJECT_PATH/cache

# Python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
export PROJECT_HOME=$PROJECT_PATH/src
export VIRTUALENVWRAPPER_SCRIPT=/usr/share/virtualenvwrapper/virtualenvwrapper.sh
source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

# Java
export JAVA_HOME="/usr/lib/jvm/default-java"

# PATH
export PATH=/usr/local/go/bin:$PROJECT_PATH/bin:$HOME/.local/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

stty sane

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/avelino/.sdkman"
[[ -s "/home/avelino/.sdkman/bin/sdkman-init.sh" ]] && source "/home/avelino/.sdkman/bin/sdkman-init.sh"
