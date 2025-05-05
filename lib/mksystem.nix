hostname: system: inputs@{ self, nixpkgs, home-manager, darwin, ... }:
let
  isDarwin = system == "aarch64-darwin";
  username = "avelino";
in
if isDarwin then
  darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs username; };
    modules = [
      home-manager.darwinModules.home-manager
      {
        networking = {
          computerName = hostname;
          hostName = hostname;
          localHostName = hostname;
        };

        # Add user
        users.users.${username} = {
          name = username;
          home = "/Users/${username}";
        };

        # Configure home-manager
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.${username} = { ... }: { };
      }
      ../hosts/darwin
    ];
  }
else
  nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs username; };
    modules = [
      home-manager.nixosModules.home-manager
      {
        networking.hostName = hostname;

        # Add user
        users.users.${username} = {
          isNormalUser = true;
          home = "/home/${username}";
          extraGroups = [ "wheel" "docker" ];
        };

        # Configure home-manager
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.${username} = { ... }: { };
      }
      ../hosts/nixos
    ];
  }