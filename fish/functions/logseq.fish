function logseq --description 'logseq shortcut with new functions'
    switch $argv[1]
        case sync
            echo "logseq: sync with git..."
            logseq icloud
            rsync -aP -q --exclude=.git --delete \
                --exclude="logseq/*/" \
                --exclude="logseq/.recycle/" \
                ~/logseq/* ~/notes/ && cd ~/notes && g st && g add . && g ci -am "$(date '+%Y-%m-%d %H:%M'): sync logseq" && g push && cd -
        case icloud
            echo "logseq: icloud sync..."
            cat ~/logseq/journals/$(date +%Y-%m-%d).md 1>/dev/null
        case '*' # default
            echo "logseq: method not fund"
    end
end
