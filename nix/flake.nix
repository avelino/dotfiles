{
  description = "Darwin system flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager }: {
    darwinConfigurations."Avelinos-Buser-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      
      modules = [
        ./configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.avelino = import ./home.nix;
        }
        {
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
      ];
    };
  };
}