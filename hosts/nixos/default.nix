{ pkgs, username, ... }:

{
  # Imports de sistema
  imports = [
    ../../modules/nix.nix
  ];

  # Permitir avaliação sem requisitos de boot/partições
  boot.isContainer = true;

  # DNS configuration for NixOS
  networking = {
    nameservers = [
      "9.9.9.9"    # Quad9 DNS
      "1.1.1.1"    # Cloudflare DNS
      "8.8.8.8"    # Google DNS
    ];
    networkmanager = {
      enable = true;
      dns = "none";  # Disable NetworkManager DNS management
    };
  };

  # Fish shell configuration
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  # Home Manager (unificado com Darwin)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username; };
    users.${username} = { pkgs, ... }: {
      home = {
        stateVersion = "23.11";
        username = username;
        homeDirectory = "/home/${username}";
      };

      imports = [
        ../../modules/home-manager/default.nix
      ];
    };
  };

  # System state version
  system.stateVersion = "23.11";
}