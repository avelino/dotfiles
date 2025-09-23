# Create required directories if they don't exist
mkdir -p $HOME/.local/share/fish
mkdir -p $HOME/.config/fish/functions
mkdir -p $HOME/.config/fish/completions
mkdir -p $HOME/.cache/fish

# Completion for nix-cmd
complete -c nix-cmd -f -n "__fish_use_subcommand" -a "upgrade" -d "Upgrade all packages"
complete -c nix-cmd -f -n "__fish_use_subcommand" -a "update" -d "Update package lists"
complete -c nix-cmd -f -n "__fish_use_subcommand" -a "search" -d "Search for a package"
complete -c nix-cmd -f -n "__fish_use_subcommand" -a "install" -d "Install a package"
complete -c nix-cmd -f -n "__fish_use_subcommand" -a "clear" -d "Clear nix store"

# Completion for logseq
complete -c logseq -f -n "__fish_use_subcommand" -a "sync" -d "Sync logseq with git"
complete -c logseq -f -n "__fish_use_subcommand" -a "cloud" -d "Initialize journal day"

# Git completions with better descriptions
complete -c g -w git
complete -c ga -w "git add"
complete -c gc -w "git commit"
complete -c gp -w "git push"
complete -c gpl -w "git pull"
complete -c gs -w "git status"
complete -c gd -w "git diff"
complete -c gl -w "git log"

# Editor completions
complete -c v -w nvim
complete -c c -w cursor
complete -c w -w windsurf
complete -c z -w zed-preview

# Check if 1Password agent is running
if test -e $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  echo "1Password SSH agent is available"
else
  echo "Warning: 1Password SSH agent socket not found"
end


