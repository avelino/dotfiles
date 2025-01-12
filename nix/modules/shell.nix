{ pkgs, ... }: let
  fishConfigFile = pkgs.writeText "config.fish" (builtins.readFile ../../fish/config.fish);
in {
  # Enable all shells for better compatibility
  programs.bash.enable = true;
  programs.zsh.enable = true;
  programs.fish = {
    enable = true;
    
    # Import existing fish configurations
    # shellInit = ''
    #   source ${fishConfigFile}
    # '';

    shellAliases = {
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      
      # Common commands
      chmox = "chmod +x";
      
      # Modern ls replacement with eza
      ls = "eza";
      ll = "eza -la";
      lt = "eza --tree";
      la = "eza -a";
      l = "eza -l";
      
      # Replace grep with ripgrep
      rg = "rg --hidden --no-heading --smart-case --color=always --line-number";
      grep = "rg";
      ag = "rg";
      
      # Docker and Kubernetes
      d = "docker";
      k = "kubectl";
      
      # Editors
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      zed = "zed-preview";
      e = "emacs";
      c = "cursor";
      
      # System tools
      htop = "sudo htop";
      wget = "curl -O";

      # git
      g = "git";
      # Nix related
      ni = "nix-instantiate";
      nix-repl = "nix repl";
      nix-shell = "nix-shell --command fish";
    };
  };

  # Global environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  # Add directories to PATH
  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "$HOME/dotfiles/bin"
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      golang.symbol = " ";
      rust.symbol = " ";
      python.symbol = " ";
      nodejs.symbol = " ";
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
} 