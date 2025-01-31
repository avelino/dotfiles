{ pkgs, ... }:
{
  nix.optimise.automatic = true;
  environment.systemPackages = with pkgs; [
    nixd
  ];
}
