function brew --description 'brew shortcut with new functions'
  switch $argv[1]
    case bkp
      rm ~/dotfiles/Brewfile && cd ~/dotfiles && brew bundle dump --force;
    case up
      brew update && brew upgrade && brew cu -ay --cleanup;
    case '*' # default
      command brew $argv;
  end
end
