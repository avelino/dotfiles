function brew --description 'brew shortcut with new functions'
    switch $argv[1]
        case bkp
            rm ~/dotfiles/Brewfile && \
            cd ~/dotfiles && \
            brew bundle dump --force && \
            defaults export NSGlobalDomain ~/dotfiles/macos/nsglobaldomain.plist
        case up
            brew update && \
            brew upgrade && \
            brew cu -ay --cleanup && \
            brew clean && \
            brew cleanup && \
            rm -rf $HOME/Library/Caches/Homebrew && \
            rm -rf $HOME/Library/Logs/Homebrew && \
            cd -
        case clean
            brew cleanup --prune=all -s -n
        case emacs
            brew services $argv[2] d12frosted/emacs-plus/emacs-plus@29
        case skhd
            skhd --$argv[2]-service
        case yabai
            yabai --$argv[2]-service
        case spacebar
            brew services $argv[2] cmacrae/formulae/spacebar
        case i3
            switch $argv[2]
                case restart
                    brew i3 stop && \
                    brew i3 start
                case "*"
                    brew yabai $argv[2] && \
                    brew skhd $argv[2] && \
                    brew spacebar $argv[2]
            end
        case '*' # default
            command brew $argv
    end
end
