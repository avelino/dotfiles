function logseq --description 'logseq shortcut with new functions'
    switch $argv[1]
        case sync
            rsync -aP --exclude=.git ~/logseq/* ~/logseq.git/ && \
                cd ~/logseq.git && \
                g add . && \
                g ci -am "$(date '+%Y-%m-%d %H:%M'): sync logseq" && \
                g push && \
                cd -
        case '*' # default
            echo "logseq method not fund"
    end
end
