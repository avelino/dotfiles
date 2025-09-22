{ pkgs, lib, inputs, username ? null, ... }:
{
  nix = {
    optimise.automatic = true;
    settings =
      (
        {
          extra-experimental-features = [ "nix-command" "flakes" ];
          warn-dirty = false;
          accept-flake-config = true;
          trusted-users = [ "root" "@admin" "@wheel" ];
          substituters = [
            "https://cache.nixos.org"
            "https://nix-community.cachix.org"
          ];
          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];
          max-jobs = lib.mkDefault "auto";
          cores = lib.mkDefault 0;
        }
        // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
          auto-optimise-store = true;
          optimise.user = "root";
        }
      );
    registry.nixpkgs.flake = inputs.nixpkgs;
    gc =
      (
        {
          automatic = true;
          options = "--delete-older-than 30d";
        }
        // lib.optionalAttrs pkgs.stdenv.isDarwin { interval = { Weekday = 0; Hour = 0; Minute = 0; }; }
        // lib.optionalAttrs pkgs.stdenv.isLinux { dates = "weekly"; }
      )
      /* Run GC as the interactive user on single-user Darwin installs to avoid permission issues. */
      // lib.optionalAttrs (pkgs.stdenv.isDarwin && username != null) { user = username; };
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
