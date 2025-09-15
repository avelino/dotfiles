{ config, pkgs, lib, ... }:

let
  # Definições centralizadas para fácil manutenção
  defaultEditor = "zed-preview";
  defaultPager = "less -FirSwX";
  logseqPaths = {
    notes = "~/notes";
    cloud = "~/logseq-avelino";
  };
in
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
      wi = "windsurf";
      z = "zed-preview";
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
      wi = "command windsurf $argv";
      v = "command nvim $argv";
      z = "command zed-preview $argv";

      # Define logseq function
      logseq = {
        description = "logseq shortcut with new functions";
        body = ''
          switch $argv[1]
            case sync
              echo "logseq: starting sync process..."

              # Ensure we're working with the latest cloud version
              logseq cloud

              # Save current directory
              set -l current_dir (pwd)

              # Sync with git repository
              if not cd ${logseqPaths.notes}
                echo "Error: Could not access notes directory"
                return 1
              end

              # Fetch and pull changes, showing any errors
              if not git pull --ff-only
                echo "Warning: Git pull failed, manual intervention may be needed"
                return 1
              end

              # Perform rsync with error checking
              if not rsync -aP -q \
                --exclude=".git/" \
                --exclude="logseq/*/" \
                --exclude="logseq/.recycle/" \
                --exclude=".trash/" \
                --delete \
                ${logseqPaths.cloud}/* ${logseqPaths.notes}/

                echo "Error: rsync failed"
                return 1
              end

              # Check if there are any changes to commit
              if git status --porcelain | grep -q .
                git add .
                git commit -m "sync(logseq): $(date '+%Y-%m-%d %H:%M')"

                if not git push
                  echo "Error: Failed to push changes"
                  return 1
                end
                echo "logseq: sync completed successfully"
              else
                echo "logseq: no changes to sync"
              end

              # Return to original directory
              cd $current_dir
            case cloud
              echo "logseq: initializing journal for today..."
              set -l journal_path ${logseqPaths.cloud}/journals/$(date +%Y-%m-%d).md

              # Check if journals directory exists
              if not test -d ${logseqPaths.cloud}/journals
                echo "Error: Journals directory not found"
                return 1
              end

              # Create journal file if it doesn't exist
              if not test -f $journal_path
                echo "- Creating new journal for $(date '+%A, %B %d, %Y')" > $journal_path
                echo "Journal created: $journal_path"
              else
                # Verify file is readable
                if test -r $journal_path
                  echo "Journal exists: $journal_path"
                else
                  echo "Error: Cannot read journal file"
                  return 1
                end
              end
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
              echo "Upgrading Nix flake inputs..."
              if test -d ~/dotfiles
                cd ~/dotfiles; and nix flake update; and cd ~
              end
              echo "Cleaning old generations..."
              if type -q darwin-rebuild
                sudo nix-collect-garbage -d
                darwin-rebuild switch --flake ~/dotfiles#$USER-igloo; or true
              else if type -q nixos-rebuild
                sudo nix-collect-garbage -d
                sudo nixos-rebuild switch --flake ~/dotfiles#$USER-zentoo; or true
              else
                echo "Note: system rebuild tool not found (darwin-rebuild/nixos-rebuild)."
              end
              echo "Upgrading Homebrew packages..."
              brew upgrade
            case update
              echo "Updating flake inputs..."
              if test -d ~/dotfiles
                cd ~/dotfiles; and nix flake update; and cd ~
              end
              echo "Updating Homebrew..."
              brew update
            case search
              if test (count $argv) -lt 2
                echo "Usage: nix-cmd search PACKAGE-NAME"
                return 1
              end
              echo "Searching in Nix packages..."
              nix search nixpkgs $argv[2]
              echo "Searching in Homebrew packages..."
              brew search $argv[2]
            case install
              if test (count $argv) -lt 2
                echo "Usage: nix-cmd install PACKAGE-NAME"
                return 1
              end
              echo "Attempting to install via Nix..."
              nix profile install nixpkgs#$argv[2]
            case rebuild
              set -l host (scutil --get LocalHostName ^/dev/null)
              if test -z "$host"
                set host (hostname -s)
              end
              if type -q darwin-rebuild
                darwin-rebuild switch --flake ~/dotfiles#$host; or true
              else if type -q nixos-rebuild
                sudo nixos-rebuild switch --flake ~/dotfiles#$host; or true
              else
                echo "System rebuild tool not found."
              end
            case clear
              if test (count $argv) -lt 2
                echo "Usage: nix-cmd clear PACKAGE-NAME"
                return 1
              end
              echo "Attempting to clear via Nix..."
              nix-collect-garbage -d
              nix store optimise
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

      # Prefer flakes; avoid legacy channels/NIX_PATH
      set -gx NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"
      set -gx NIX_SSL_CERT_FILE /nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt

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
      complete -c w -w windsurf
      complete -c z -w zed-preview

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
      EDITOR = defaultEditor;
      VISUAL = defaultEditor;
      PAGER = defaultPager;
      MANPAGER = defaultPager;
      SSH_AUTH_SOCK = "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
      # eza color theme aligned to Monokai Pro (Filter Ristretto)
      # di (dir) = #FF955C (orange), ln (symlink) = #78DCE8, ex (exec) = #A9DC76
      # fi (file) = #FCFCFA, or (orphan) = #FF6188
      EZA_COLORS = "di=38;2;255;149;92:ln=38;2;120;220;232:ex=38;2;169;220;118:fi=38;2;252;252;250:or=38;2;255;97;136";
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
