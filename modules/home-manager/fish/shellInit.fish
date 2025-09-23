# Fish configuration
set fish_greeting

# Set specific path for universal variables
set -g fish_universal_variables_path $HOME/.config/fish/fish_variables

# Set XDG default variables
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_CACHE_HOME $HOME/.cache

# Setup 1Password SSH agent
set -gx SSH_AUTH_SOCK $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# Prefer flakes; avoid legacy channels/NIX_PATH
set -gx NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
set -gx NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt
set -e NIX_PATH

# Set up PATH with Nix and Homebrew paths
if test (uname) = "Darwin"
  set -gx PATH $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin /opt/homebrew/bin $PATH
else
  set -gx PATH $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin $PATH
end

# Source nix setup if it exists
if test -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
end

# fzf configuration
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border --cycle --preview 'bat --style=numbers --color=always --line-range :500 {}'"
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

# Enable fzf key bindings
fzf_configure_bindings --directory=\cf --git_log=\cg --git_status=\cs --processes=\cp --variables=\cv


