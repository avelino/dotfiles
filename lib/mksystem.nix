hostname: system: inputs@{ nixpkgs, home-manager, darwin, ... }:
let
  isDarwin = system == "aarch64-darwin";
  username = "avelino";
  overlays = import ./overlays.nix inputs;
in
if isDarwin then
  darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs username hostname; };
    modules = [
      { nixpkgs.overlays = [ overlays.unstableOverlay ]; }
      home-manager.darwinModules.home-manager
      ../hosts/darwin
    ];
  }
else
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs username hostname; };
    modules = [
      { nixpkgs.overlays = [ overlays.unstableOverlay ]; }
      home-manager.nixosModules.home-manager
      ../hosts/nixos
    ];
  }
