if status is-interactive
    # Commands to run in interactive sessions can go here
    source ~/.config/fish/aliases.fish
    set -gx GPG_TTY (tty)
    keychain --agents ssh --eval id_rsa | source
    set EDITOR "e"
    set MACPREFS_BACKUP_DIR "~/Google Drive/My Drive/config/macprefs"

    if test -z (pgrep ssh-agent)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
end
