{
  description = "Avelino's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
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
      username = "avelino";
    in
    {
      darwinConfigurations."${username}-igloo" = mkSystem "${username}-igloo" "aarch64-darwin" inputs;
      darwinConfigurations."${username}-kazoo" = mkSystem "${username}-kazoo" "aarch64-darwin" inputs;
      nixosConfigurations."${username}-zentoo" = mkSystem "${username}-zentoo" "x86_64-linux" inputs;

      devShells = {
        aarch64-darwin.default = nixpkgs.legacyPackages.aarch64-darwin.mkShell {
          packages = with nixpkgs.legacyPackages.aarch64-darwin; [ nixd nixfmt-classic statix ];
        };
        x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
          packages = with nixpkgs.legacyPackages.x86_64-linux; [ nixd nixfmt-classic statix ];
        };
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-classic;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-classic;
    };
}
