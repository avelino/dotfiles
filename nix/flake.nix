{
  description = "Darwin system configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    
    # Homebrew taps
    # TODO: this bunch of homebrew tap is messy, I need to review which ones are **important**
    homebrew-core = { url = "github:homebrew/homebrew-core"; flake = false; };
    homebrew-cask = { url = "github:homebrew/homebrew-cask"; flake = false; };
    homebrew-bundle = { url = "github:homebrew/homebrew-bundle"; flake = false; };
    homebrew-services = { url = "github:homebrew/homebrew-services"; flake = false; };
    homebrew-cask-fonts = { url = "github:homebrew/homebrew-cask-fonts"; flake = false; };
    homebrew-autoupdate = { url = "github:homebrew/homebrew-autoupdate"; flake = false; };
    adoptopenjdk-openjdk = { url = "github:adoptopenjdk/homebrew-openjdk"; flake = false; };
    borkdude-brew = { url = "github:borkdude/homebrew-brew"; flake = false; };
    bukalapak-packages = { url = "github:bukalapak/homebrew-packages"; flake = false; };
    buo-cask-upgrade = { url = "github:buo/homebrew-cask-upgrade"; flake = false; };
    # clojure-lsp-brew = { url = "github:clojure-lsp/homebrew-brew"; flake = false; };
    cmacrae-formulae = { url = "github:cmacrae/homebrew-formulae"; flake = false; };
    d12frosted-emacs-plus = { url = "github:d12frosted/homebrew-emacs-plus"; flake = false; };
    dart-lang-dart = { url = "github:dart-lang/homebrew-dart"; flake = false; };
    gabrie30-utils = { url = "github:gabrie30/homebrew-utils"; flake = false; };
    github-gh = { url = "github:github/homebrew-gh"; flake = false; };
    graalvm-tap = { url = "github:graalvm/homebrew-tap"; flake = false; };
    heroku-brew = { url = "github:heroku/homebrew-brew"; flake = false; };
    int128-kubelogin = { url = "github:int128/homebrew-kubelogin"; flake = false; };
    jeroenknoops-tap = { url = "github:jeroenknoops/homebrew-tap"; flake = false; };
    johanhaleby-kubetail = { url = "github:johanhaleby/homebrew-kubetail"; flake = false; };
    koekeishiya-formulae = { url = "github:koekeishiya/homebrew-formulae"; flake = false; };
    mongodb-brew = { url = "github:mongodb/homebrew-brew"; flake = false; };
    pritunl-tap = { url = "github:pritunl/homebrew-tap"; flake = false; };
    puma-puma = { url = "github:puma/homebrew-puma"; flake = false; };
    ravenac95-sudolikeaboss = { url = "github:ravenac95/homebrew-sudolikeaboss"; flake = false; };
    screenplaydev-tap = { url = "github:screenplaydev/homebrew-tap"; flake = false; };
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-master, home-manager, darwin, nix-homebrew,
    homebrew-core, homebrew-cask, homebrew-bundle, homebrew-services, homebrew-cask-fonts,
    homebrew-autoupdate, adoptopenjdk-openjdk, borkdude-brew, bukalapak-packages,
    buo-cask-upgrade, cmacrae-formulae, d12frosted-emacs-plus,
    dart-lang-dart, gabrie30-utils, github-gh, graalvm-tap, heroku-brew,
    int128-kubelogin, jeroenknoops-tap, johanhaleby-kubetail, koekeishiya-formulae,
    mongodb-brew, pritunl-tap, puma-puma, ravenac95-sudolikeaboss, screenplaydev-tap }: 
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      specialArgs = { 
        inherit nix-homebrew homebrew-core homebrew-cask homebrew-bundle
        homebrew-services homebrew-cask-fonts homebrew-autoupdate
        adoptopenjdk-openjdk borkdude-brew bukalapak-packages
        buo-cask-upgrade cmacrae-formulae
        d12frosted-emacs-plus dart-lang-dart gabrie30-utils
        github-gh graalvm-tap heroku-brew int128-kubelogin
        jeroenknoops-tap johanhaleby-kubetail koekeishiya-formulae
        mongodb-brew pritunl-tap puma-puma ravenac95-sudolikeaboss
        screenplaydev-tap;
      };
    in {
      darwinConfigurations."darwin" = darwin.lib.darwinSystem {
        inherit system specialArgs;
        modules = [
          {
            nixpkgs.config = {
              allowUnfree = true;
              allowUnsupportedSystem = true;
              allowBroken = true;
              permittedInsecurePackages = [
                "openssl-1.1.1w"
              ];
            };
          }
          ./configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.avelino = { pkgs, lib, ... }: {
                imports = [ ./home.nix ];
                home = {
                  username = "avelino";
                  homeDirectory = lib.mkForce "/Users/avelino";
                  stateVersion = "23.11";
                };
              };
            };
          }
        ];
      };
    };
}