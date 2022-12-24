# basically it checks whether we have a running emacs server; if we don't, it starts one
function e
    emacsclient -c -a '' --no-wait $argv
end
