{
  description = "Darwin system flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."avelino" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        
        # Specify the path to your home-manager configuration
        modules = [ ./home.nix ];
        
        # Specify your home directory
        extraSpecialArgs = {
          inherit system;
        };
      };
    };
}