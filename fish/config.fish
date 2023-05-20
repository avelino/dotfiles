string match -q "$TERM_PROGRAM" vscode and . (code --locate-shell-integration-path fish)
if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
    source ~/.config/fish/aliases.fish
    # source ~/.config/private-env.fish
    set -gx GPG_TTY (tty)
    keychain --agents ssh --eval id_rsa | source
    set EDITOR e
    set MACPREFS_BACKUP_DIR '/Users/avelino/Library/CloudStorage/GoogleDrive-avelinorun@gmail.com/My Drive/config/macprefs'
    # set -gx DOCKER_HOST tcp://ws.avelino:2375
    set -gx DOCKER_HOST ssh://ws.avelino:22

    # if test -z (pgrep ssh-agent)
    if ps -p $SSH_AGENT_PID >/dev/null
        echo "ssh-agent is already running"
    else
        eval (ssh-agent -s)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
end
