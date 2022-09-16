function brewbkp --wraps='rm ~/dotfiles/Brewfile && cd ~/dotfiles && brew bundle dump' --description 'alias brewbkp=rm ~/dotfiles/Brewfile && cd ~/dotfiles && brew bundle dump'
  rm ~/dotfiles/Brewfile && cd ~/dotfiles && brew bundle dump $argv; 
end
