alias g=git
alias G=g
alias vim=nvim
alias v=nvim
alias e=emacs_open
alias es=emacs_start
alias idea="open -na \"IntelliJ IDEA.app\" --args \"$@\""
# alias es="emacs --eval '(setq server-name \"avelino\")' --daemon"
alias ex=emacsx_start
# alias ex="emacsclient -cnfs --socket-name avelino"
alias esk=emacs_kill
# alias esk="killall emacs"
alias emacs="emacs -nw"
alias eopen="emacsclient -n"
#alias code="code-insiders"
alias tmux="tmux -u"
alias htop="TERM=screen htop"
alias gl="git log --graph --pretty='format:%C(yellow)%h%Cblue%d%Creset %s %C(white) %an, %ar%Creset'"
alias loadrbenv='rbenv init -'
alias loadrvm='[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"'
alias loadnvm='[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh" && [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"'
alias loadpyenv='pyenv init -'
alias loadtravis='[ -f $HOME/.travis/travis.sh ] && . "$HOME/.travis/travis.sh"'
alias brewup='brew update && brew upgrade && brew cu -ay --cleanup'
alias brewbkp='rm ~/dotfiles/Brewfile && cd ~/dotfiles && brew bundle dump'

function emacs_session_name(){
    TMUX_SESSION=$(tmux display-message -p '#S')
    SESSION="${TMUX_SESSION}-${PWD##*/}"
}

function emacs_start(){
    emacs_session_name
    emacs --eval "(setq server-name \"$SESSION\")" --daemon
}

function emacsx_start(){
    emacs_session_name
    emacsclient -cnfs --socket-name $SESSION
}

function emacs_kill(){
    emacs_session_name
    killall emacs $SESSION
}

function emacs_open(){
    emacs_session_name
    {
	emacsclient -nw --socket-name $SESSION $1
    } || {
	emacs_start
	emacsclient -nw --socket-name $SESSION $1
    }
}

open_project() {
    cd ~/src/github.com/$1
}
alias oproject=open_project
