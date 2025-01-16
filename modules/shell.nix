{ pkgs, ... }:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
  # Fish shell configuration
  programs.fish = {
    enable = true;
    useBabelfish = true;
    babelfishPackage = pkgs.babelfish;

    shellAliases = {
      # File listing aliases
      ls = "eza";
      ll = "eza -l";
      la = "eza -la";
      lt = "eza --tree";
      l = "eza -l";
      tree = "eza --tree";

      # Git aliases
      g = "git";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull";
      gs = "git status";
      gd = "git diff";
      gl = "git log";

      # editor aliases
      c = "cursor";
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      e = "emacs";
      em = "emacs";
      ems = "emacs";
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
    '';

    interactiveShellInit = ''
      # Create required directories if they don't exist
      mkdir -p $HOME/.local/share/fish
      mkdir -p $HOME/.config/fish
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

  # General shell configuration
  environment.shells = [ pkgs.fish ];
  users.users.avelino.shell = pkgs.fish;
  environment.variables = {
    SHELL = "${pkgs.fish}/bin/fish";
    EDITOR = "cursor";
    VISUAL = "cursor";
    # Add 1Password SSH agent environment variable
    SSH_AUTH_SOCK = "${home}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
  };

  # Configure Fish directories permissions during system activation
  system.activationScripts = {
    fishSetup = {
      text = ''
        echo "Setting up Fish directories..."
        install -d -m 755 -o avelino -g staff ${home}/.config/fish
        touch ${home}/.config/fish/fish_variables
        chown avelino:staff ${home}/.config/fish/fish_variables
        chmod 644 ${home}/.config/fish/fish_variables
      '';
      deps = [];
    };
  };
}