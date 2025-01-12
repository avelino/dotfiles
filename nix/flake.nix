{
  description = "Darwin system flake";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-casks = {
      url = "github:atahanyorganci/nix-casks/archive";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs }: {
    darwinConfigurations."Avelinos-Buser-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";  # Para M1/M2 Macs
      # Use "x86_64-darwin" para Intel Macs
      
      modules = [
        ./configuration.nix
      ];
    };
  };
}