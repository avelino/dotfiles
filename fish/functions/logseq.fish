function logseq --description 'logseq shortcut with new functions'
  switch $argv[1]
    case sync
      cd ~/Google\ Drive/My\ Drive/logseq/avelino && \
         g add . && \
         g ci -am "$(date '+%Y-%m-%d %H:%M'): sync logseq";
    case '*' # default
      echo "logseq method not fund";
  end
end
