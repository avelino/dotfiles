{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;

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
    '';

    interactiveShellInit = ''
      # Create required directories if they don't exist
      mkdir -p $HOME/.local/share/fish
      mkdir -p $HOME/.config/fish/functions
      mkdir -p $HOME/.cache/fish

      # Define logseq function
      function logseq --description 'logseq shortcut with new functions'
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
      end

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

    # Create Fish directories
    file = {
      ".config/fish/.keep".text = "";
    };
  };
}