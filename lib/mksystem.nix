hostname: system: inputs@{ self, nixpkgs, home-manager, darwin, ... }:
let
  isDarwin = system == "aarch64-darwin";
in
if isDarwin then
  darwin.lib.darwinSystem {
    inherit system;
    modules = [
      home-manager.darwinModules.home-manager
      {
        nixpkgs.config.allowUnfree = true;
        networking.hostName = hostname;
      }
      ../hosts/darwin
    ];
  }
else
  nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [
      home-manager.nixosModules.home-manager
      {
        nixpkgs.config.allowUnfree = true;
        networking.hostName = hostname;
      }
      ../hosts/nixos
    ];
  } 