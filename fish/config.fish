if status is-interactive
    export SHELL=fish
    # Commands to run in interactive sessions can go here
    set -U fish_user_paths /opt/homebrew/bin $fish_user_paths
    set -U fish_user_paths ~/dotfiles/bin $fish_user_paths
    set -U fish_user_paths ~/.emacs.d/bin $fish_user_paths
    set -U fish_user_paths ~/.cargo/bin $fish_user_paths
    source ~/.config/fish/aliases.fish
    # source ~/.config/private-env.fish
    set -gx GPG_TTY (tty)
    keychain --agents ssh --eval id_rsa | source
    set -gx EDITOR nvim

    # set -gx DOCKER_HOST tcp://ws.avelino:2375
    # set -gx DOCKER_HOST ssh://ws.avelino:22

    # lang en_US UTF8
    set -gx LANGUAGE "en_US.UTF-8"
    set -gx LC_ALL
    set -gx LC_CTYPE "en_US.UTF-8"
    set -gx LANG "en_US.UTF-8"

    # if test -z (pgrep ssh-agent)
    if ps -p "$SSH_AGENT_PID" >/dev/null
        echo "ssh-agent is already running"
    else
        eval (ssh-agent -s)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
end
