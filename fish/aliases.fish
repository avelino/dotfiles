## Navigation
function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end

alias chmox 'chmod +x'

## change grep tools to ripgrep
# alias ag='ag --follow --hidden -W (math $COLUMNS - 11)'
alias rg "rg --hidden --no-heading --smart-case --color=always --line-number"
alias grep rg
alias ag rg

## docker / k8s
alias d docker
alias k kubectl

alias vim nvim
alias vi nvim
alias zed zed-preview

## htop requires root privileges to correctly display all running processes, so you will need to run `sudo htop`
alias htop "sudo htop"

## wget sucks with certificates. Let's keep it simple.
alias wget "curl -O"

set -gx GPG_TTY (tty)
