# basically it checks whether we have a running emacs server; if we don't, it starts one
function e
    # use emacsclient if we have a running server
    # emacs -nw $argv
    emacsclient -c $argv
end
