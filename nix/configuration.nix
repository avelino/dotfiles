{ pkgs, ... }: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);


  system.defaults.dock.autohide = true;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    vim
    git
    fish
    tmux
    neovim
    python3
  ] ++ (with nix-casks.packages.aarch64-darwin; [
    # casks
    _1password
    raycast
    zen-browser
    cursor
    logseq
    morgen
    rio
    orbstack
  ]);
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 5;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
} 