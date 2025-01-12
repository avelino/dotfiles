{ config, pkgs, ... }:

{
  home.username = "seu_usuario";
  home.homeDirectory = "/home/seu_usuario";
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Import existing configurations
  imports = [
    ./modules/fish.nix
    ./modules/git.nix
    # Add other module imports as needed
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
} 