# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

alias chmox='chmod +x'
alias ag='ag --follow --hidden -W (math $COLUMNS - 11)'

# docker / k8s
alias d docker
alias k kubectl

# wget sucks with certificates. Let's keep it simple.
alias wget="curl -O"

set -gx GPG_TTY (tty)
