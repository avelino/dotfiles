hostname: system: inputs@{ nixpkgs, home-manager, darwin, ... }:
let
  isDarwin = system == "aarch64-darwin";
  username = "avelino";
in
if isDarwin then
  darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs username hostname; };
    modules = [
      home-manager.darwinModules.home-manager
      ../hosts/darwin
    ];
  }
else
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs username hostname; };
    modules = [
      home-manager.nixosModules.home-manager
      ../hosts/nixos
    ];
  }