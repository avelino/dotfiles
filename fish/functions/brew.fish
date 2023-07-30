function brew --description 'brew shortcut with new functions'
    switch $argv[1]
        case bkp
            rm ~/dotfiles/Brewfile && cd ~/dotfiles && brew bundle dump --force
        case up
            brew update && brew upgrade && brew cu -ay --cleanup && brew clean
        case clean
            brew cleanup --prune=all -s -n
        case emacs
            brew services $argv[2] d12frosted/emacs-plus/emacs-plus@28
        case skhd
            skhd --$argv[2]-service
        case yabai
            yabai --$argv[2]-service
        case '*' # default
            command brew $argv
    end
end
