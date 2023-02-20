# basically it checks whether we have a running emacs server; if we don't, it starts one
function e
    emacs -nw $argv
end
