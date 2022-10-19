if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.config/fish/aliases.fish
    set -gx GPG_TTY (tty)
    keychain --agents ssh --eval id_rsa | source
    set EDITOR "e" 
end
