{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "v9.8";
          sha256 = "sha256-xWaMd5POCDeeFTsGtHbIvsPelIp+GZPC1X1CseCo3BA=";
        };
      }
    ];

    # Custom completions
    shellAbbrs = {
      g = "git";
      v = "nvim";
      c = "cursor";
    };

    functions = {
      ls = "command eza $argv";
      ll = "command eza -l $argv";
      la = "command eza -la $argv";
      lt = "command eza --tree $argv";
      l = "command eza -l $argv";
      tree = "command eza --tree $argv";

      # Git functions
      g = "command git $argv";
      ga = "command git add $argv";
      gc = "command git commit $argv";
      gp = "command git push $argv";
      gpl = "command git pull $argv";
      gs = "command git status $argv";
      gd = "command git diff $argv";
      gl = "command git log $argv";

      # editor
      c = "command cursor $argv";
      v = "command nvim $argv";

      # Define logseq function
      logseq = {
        description = "logseq shortcut with new functions";
        body = ''
          switch $argv[1]
            case sync
              echo "logseq: sync with git..."
              logseq cloud
              cd ~/notes && g pull -f
              rsync -aP -q --exclude=.git --delete \
                --exclude="logseq/*/" \
                --exclude="logseq/.recycle/" \
                ~/logseq-avelino/* ~/notes/ && \
                git st && \
                git add . && \
                git ci -am "$(date '+%Y-%m-%d %H:%M'): sync logseq" && \
                git push && \
                cd -
            case cloud
              echo "logseq: journal day init..."
              cat ~/logseq-avelino/journals/$(date +%Y-%m-%d).md 1>/dev/null
            case '*'
              echo "logseq: method not fund"
          end
        '';
      };

      # Define nix-cmd function
      nix-cmd = {
        description = "nix and homebrew environment management";
        body = ''
          switch $argv[1]
            case upgrade
              nix-cmd update
              echo "Upgrading Nix packages..."
              nix-env -u
              cd ~/dotfiles && nix flake update && cd ~
              nix-env --delete-generations
              echo "Upgrading Homebrew packages..."
              brew upgrade
            case update
              echo "Updating Nix channels..."
              nix-channel --update
              echo "Updating Homebrew..."
              brew update
            case search
              if test (count $argv) -lt 2
                echo "Usage: nix-cmd search PACKAGE-NAME"
                return 1
              end
              echo "Searching in Nix packages..."
              nix-env -qaP $argv[2]
              echo "Searching in Homebrew packages..."
              brew search $argv[2]
            case install
              if test (count $argv) -lt 2
                echo "Usage: nix-cmd install PACKAGE-NAME"
                return 1
              end
              echo "Attempting to install via Nix..."
              nix-env -iA nixpkgs.$argv[2]
            case clear
              if test (count $argv) -lt 2
                echo "Usage: nix-cmd clear PACKAGE-NAME"
                return 1
              end
              echo "Attempting to clear via Nix..."
              nix-env --delete-generations
              nix-store --gc
            case '*'
              echo "Usage: nix-cmd [upgrade|update|search|install] [PACKAGE-NAME]"
              echo "  upgrade: Upgrade all packages"
              echo "  update: Update package lists"
              echo "  search PACKAGE-NAME: Search for a package"
              echo "  install PACKAGE-NAME: Install a package"
          end
        '';
      };
    };

    shellInit = ''
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

      # Set up Nix paths
      set -gx NIX_PATH $HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/$USER/channels
      set -gx NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
      set -gx NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt

      # Set up PATH with Nix and Homebrew paths
      set -gx PATH $HOME/.nix-profile/bin /nix/var/nix/profiles/default/bin /run/current-system/sw/bin /opt/homebrew/bin $PATH

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
    '';

    interactiveShellInit = ''
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

      # Check if 1Password agent is running
      if test -e $HOME/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
        echo "1Password SSH agent is available"
      else
        echo "Warning: 1Password SSH agent socket not found"
      end
    '';
  };

  home = {
    sessionVariables = {
      SHELL = "${pkgs.fish}/bin/fish";
      EDITOR = "cursor";
      VISUAL = "cursor";
      PAGER = "less -FirSwX";
      MANPAGER = "less -FirSwX";
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
    };

    packages = with pkgs; [
      fzf
      fd
      bat
    ];

    # Create Fish directories
    file = {
      ".config/fish/.keep".text = "";
    };
  };
}
