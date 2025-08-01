{
  description = "Avelino's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      darwin,
      ...
    }@inputs:
    let
      mkSystem = import ./lib/mksystem.nix;
      nixpkgsConfig = {
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
      };
      username = "avelino";
    in
    {
      darwinConfigurations."${username}-igloo" = mkSystem "${username}-igloo" "aarch64-darwin" inputs;
      darwinConfigurations."${username}-kazoo" = mkSystem "${username}-kazoo" "aarch64-darwin" inputs;
      nixosConfigurations."${username}-zentoo" = mkSystem "${username}-zentoo" "x86_64-linux" inputs;
    };
}
