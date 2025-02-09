{ pkgs, ... }:
{
  nix = {
    optimise.automatic = true;
    settings = {
      extra-experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      accept-flake-config = true;
      sandbox = false; # Temporarily disable sandbox for macOS builds
      trusted-users = [ "root" "@admin" "@wheel" ];
      max-jobs = "auto";
      cores = 0;
    };
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 0; Minute = 0; }; # Run at midnight on Sundays
      options = "--delete-older-than 30d";
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
      build-users-group = nixbld
    '';
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      permittedInsecurePackages = [ ];
    };
  };

  environment.systemPackages = with pkgs; [
    nixd
  ];
}
