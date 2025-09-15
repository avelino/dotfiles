{ pkgs, lib, inputs, ... }:
{
  nix = {
    optimise.automatic = true;
    settings = {
      extra-experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      accept-flake-config = true;
      trusted-users = [ "root" "@admin" "@wheel" ];
      max-jobs = "auto";
      cores = 0;
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    gc =
      {
        automatic = true;
        options = "--delete-older-than 30d";
      }
      // (lib.optionalAttrs pkgs.stdenv.isDarwin { interval = { Weekday = 0; Hour = 0; Minute = 0; }; })
      // (lib.optionalAttrs pkgs.stdenv.isLinux { dates = "weekly"; });
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
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
