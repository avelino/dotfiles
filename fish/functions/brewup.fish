function brewup --wraps='ls -l' --wraps='brew update && brew upgrade && brew cu -ay --cleanup' --description 'alias brewup=brew update && brew upgrade && brew cu -ay --cleanup'
  brew update && brew upgrade && brew cu -ay --cleanup $argv; 
end
