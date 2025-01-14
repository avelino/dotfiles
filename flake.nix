{
  description = "Avelino's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix;
      nixpkgsConfig = {
        config = {
          allowUnsupportedSystem = true;
        };
      };
    in
    {
      darwinConfigurations."default" = mkSystem "darwin" "aarch64-darwin" inputs;
      nixosConfigurations."nixos" = mkSystem "nixos" "x86_64-linux" inputs;
    };
} 