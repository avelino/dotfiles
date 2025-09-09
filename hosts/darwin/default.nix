{ config, pkgs, username, hostname, ... }:

{
  # Import modules
  imports = [
    ../../modules/nix.nix
    ../../modules/darwin/preferences.nix
    ../../modules/darwin/dock.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/homebrew.nix
  ];

  # Define system state version (required)
  system.stateVersion = 5;

  # Hostnames e usuário
  networking = {
    computerName = hostname;
    hostName = hostname;
    localHostName = hostname;
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # Configure home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username; };
    users.${username} = { pkgs, ... }: {
      home = {
        stateVersion = "23.11";
        username = username;
        homeDirectory = "/Users/${username}";
      };

      programs = {
        home-manager.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        # vscode.enable = true; # Enable VSCode configuration
      };

      imports = [
        ../../modules/home-manager/default.nix
        ../../modules/home-manager/aerospace.nix
      ];
    };
  };

  # Ensure 1Password is always running
  launchd.user.agents."1password" = {
    serviceConfig = {
      Program = "/Applications/1Password.app/Contents/MacOS/1Password";
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/tmp/1password.out.log";
      StandardErrorPath = "/tmp/1password.err.log";
    };
  };

  # System packages: manter apenas o essencial de sistema
  environment.systemPackages = with pkgs; [
    eza
    btop
    htop
    bat
    delta
    direnv
    fzf
    ripgrep
    fd
    yq
    silver-searcher
    cmake
    fish
    maple-mono-NF
    font-awesome
  ];

  # Enable TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Configuração do fish para nix-darwin
  programs.fish.enable = true;
  environment.shells = with pkgs; [ bash zsh fish ];
}
