{ pkgs, lib, ... }: {
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Import modules
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/editors.nix
    ./modules/terminal.nix
    ./modules/packages.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
} 