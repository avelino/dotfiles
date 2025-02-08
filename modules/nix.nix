{ pkgs, ... }:
{
  nix = {
    optimise.automatic = true;
    settings = {
      extra-experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
      accept-flake-config = true;
    };
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
