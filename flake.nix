{
  description = "Avelino's system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    "nixpkgs-unstable".url = "github:nixos/nixpkgs/nixos-unstable";
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
      overlays = import ./lib/overlays.nix inputs;
      username = "avelino";
      supportedSystems = [ "aarch64-darwin" "x86_64-linux" ];
      forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
      mkPkgs = system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            allowBroken = false;
          };
          overlays = [ overlays.unstableOverlay ];
        };
    in
    {
      darwinConfigurations."${username}-igloo" = mkSystem "${username}-igloo" "aarch64-darwin" inputs;
      darwinConfigurations."${username}-kazoo" = mkSystem "${username}-kazoo" "aarch64-darwin" inputs;
      nixosConfigurations."${username}-zentoo" = mkSystem "${username}-zentoo" "x86_64-linux" inputs;

      devShells = forEachSystem (system:
        let
          pkgs = mkPkgs system;
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [ nixd nixfmt-classic statix ];
          };
        });

      formatter = forEachSystem (system:
        let
          pkgs = mkPkgs system;
        in
        pkgs.nixfmt-classic);
    };
}
