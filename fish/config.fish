source ~/.config/fish/aliases.fish
set -gx GPG_TTY (tty)

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -x GITLAB_PERSONAL_ACCESS_TOKEN glpat-jEtNuhGH1EEVJfAxFYt1
end
