{ pkgs, ... }:

{
  # Import modules
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
  ];

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
  users.users.avelino = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    eza
  ];

  # System state version
  system.stateVersion = "23.11";
} 