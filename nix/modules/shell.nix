{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      
      # Configure environment variables
      set -gx EDITOR nvim
      set -gx VISUAL $EDITOR
      set -gx LANG en_US.UTF-8
      set -gx LC_ALL en_US.UTF-8
      
      # Go configuration
      set -gx GOPATH $HOME/go
      set -gx PATH $GOPATH/bin $PATH
      
      # Rust configuration
      set -gx PATH $HOME/.cargo/bin $PATH
    '';
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "+FUBM7CodtZrYKqU542fQD+ZDGrd2438trKM0tIESs0=";
        };
      }
    ];
    shellAliases = {
      g = "git";
      gc = "git commit";
      gp = "git push";
      gpl = "git pull";
      gst = "git status";
      
      cat = "bat";
      ls = "exa";
      ll = "exa -la";
      tree = "exa --tree";
      
      dev = "cd ~/Development";
      dots = "cd ~/dotfiles";
      
      d = "docker";
      dc = "docker-compose";
      
      vim = "nvim";
      vi = "nvim";
      
      c = "cursor";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
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
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };
} 