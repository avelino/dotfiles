function logseq --description 'logseq shortcut with new functions'
    switch $argv[1]
        case sync
            echo "logseq: sync with git..."
            logseq cloud
            cd ~/notes && g pull -f
            rsync -aP -q --exclude=.git --delete \
                --exclude="logseq/*/" \
                --exclude="logseq/.recycle/" \
                ~/logseq-avelino/* ~/notes/ && \
            git st && \
            git add . && \
            git ci -am "$(date '+%Y-%m-%d %H:%M'): sync logseq" && \
            git push && \
            cd -
        case cloud
            echo "logseq: journal day init..."
            cat ~/logseq-avelino/journals/$(date +%Y-%m-%d).md 1>/dev/null
        case '*' # default
            echo "logseq: method not fund"
    end
end
