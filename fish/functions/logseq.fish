function logseq --description 'logseq shortcut with new functions'
    switch $argv[1]
        case sync
            cd ~/logseq/avelino && g add . && g ci -am "$(date '+%Y-%m-%d %H:%M'): sync logseq" && g push
        case '*' # default
            echo "logseq method not fund"
    end
end
