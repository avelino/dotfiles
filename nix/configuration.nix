{ config, pkgs, lib, nix-homebrew, homebrew-core, homebrew-cask, homebrew-bundle,
  homebrew-services, homebrew-cask-fonts, homebrew-autoupdate,
  adoptopenjdk-openjdk, borkdude-brew, bukalapak-packages,
  buo-cask-upgrade, cmacrae-formulae,
  d12frosted-emacs-plus, dart-lang-dart, gabrie30-utils,
  github-gh, graalvm-tap, heroku-brew, int128-kubelogin,
  jeroenknoops-tap, johanhaleby-kubetail, koekeishiya-formulae,
  mongodb-brew, pritunl-tap, puma-puma, ravenac95-sudolikeaboss,
  screenplaydev-tap, ... }: {
  # Nix configuration ------------------------------------------------------------------------------

  nix.settings.substituters = [
    "https://cache.nixos.org/"
  ];
  nix.settings.trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
  nix.settings.trusted-users = [
    "@admin"
  ];
  nix.configureBuildUsers = true;

  # Enable experimental nix command and flakes
  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    keep-outputs = true
    keep-derivations = true
  '';

  # Shell configuration
  environment.shells = with pkgs; [ fish ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Apps
  # `home-manager` currently has issues adding them to `~/Applications`
  # Issue: https://github.com/nix-community/home-manager/issues/1341
  environment.systemPackages = with pkgs; [
    terminal-notifier
  ];

  # https://github.com/nix-community/home-manager/issues/423
  environment.variables = {
    TERMINFO_DIRS = lib.mkForce "${pkgs.kitty.terminfo.outPath}/share/terminfo";
  };
  programs.nix-index.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    recursive
    nerd-fonts.jetbrains-mono
  ];

  # Keyboard
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # System state version
  system.stateVersion = 5;

  # Fix Homebrew permissions on activation
  system.activationScripts.extraActivation.text = ''
    echo "setting up homebrew directories..."
    sudo rm -rf /opt/homebrew
    sudo mkdir -p /opt/homebrew
    sudo mkdir -p /opt/homebrew/Library
    sudo mkdir -p /opt/homebrew/Library/Taps
    sudo mkdir -p /opt/homebrew/Library/Taps/clojure-lsp
    
    # Set permissions for all Homebrew directories
    sudo chmod -R 777 /opt/homebrew
    sudo chown -R ${config.nix-homebrew.user}:admin /opt/homebrew
  '';

  # Nix Homebrew Configuration
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "avelino";
    autoMigrate = true;
    mutableTaps = true;
    taps = {
      "homebrew/homebrew-core" = homebrew-core;
      "homebrew/homebrew-cask" = homebrew-cask;
      "homebrew/homebrew-bundle" = homebrew-bundle;
      "homebrew/services" = homebrew-services;
      "homebrew/cask-fonts" = homebrew-cask-fonts;
      "homebrew/autoupdate" = homebrew-autoupdate;
      "adoptopenjdk/openjdk" = adoptopenjdk-openjdk;
      "borkdude/brew" = borkdude-brew;
      "bukalapak/packages" = bukalapak-packages;
      "buo/cask-upgrade" = buo-cask-upgrade;
      "cmacrae/formulae" = cmacrae-formulae;
      "d12frosted/emacs-plus" = d12frosted-emacs-plus;
      "dart-lang/dart" = dart-lang-dart;
      "gabrie30/utils" = gabrie30-utils;
      "github/gh" = github-gh;
      "graalvm/tap" = graalvm-tap;
      "heroku/brew" = heroku-brew;
      "int128/kubelogin" = int128-kubelogin;
      "jeroenknoops/tap" = jeroenknoops-tap;
      "johanhaleby/kubetail" = johanhaleby-kubetail;
      "koekeishiya/formulae" = koekeishiya-formulae;
      "mongodb/brew" = mongodb-brew;
      "pritunl/tap" = pritunl-tap;
      "puma/puma" = puma-puma;
      "ravenac95/sudolikeaboss" = ravenac95-sudolikeaboss;
      "screenplaydev/tap" = screenplaydev-tap;
    };
  };

  # Homebrew Configuration
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      cleanup = "none";
      upgrade = false;
    };
    global = {
      brewfile = true;
      lockfiles = false;
    };
    taps = [
      "clojure-lsp/brew"
    ];
    brews = [
      "clojure-lsp/brew/clojure-lsp-native"
    ];
    casks = [
      { name = "arc"; greedy = true; }
      { name = "raycast"; greedy = true; }
      { name = "zed@preview"; greedy = true; }
      { name = "1password"; greedy = true; }
      { name = "orbstack"; greedy = true; }
      { name = "visual-studio-code"; greedy = true; }
      { name = "slack"; greedy = true; }
      { name = "spotify"; greedy = true; }
      { name = "zoom"; greedy = true; }
      { name = "cursor"; greedy = true; }
      { name = "appcleaner"; greedy = true; }
      { name = "daisydisk"; greedy = true; }
      { name = "figma"; greedy = true; }
      { name = "font-awesome-terminal-fonts"; greedy = true; }
      { name = "font-cascadia-code"; greedy = true; }
      { name = "font-fira-code"; greedy = true; }
      { name = "font-fontawesome"; greedy = true; }
      { name = "font-hack-nerd-font"; greedy = true; }
      { name = "font-maple"; greedy = true; }
      { name = "font-source-code-pro"; greedy = true; }
      { name = "google-chrome"; greedy = true; }
      { name = "google-drive"; greedy = true; }
      { name = "chromedriver"; greedy = true; }
      { name = "gpg-suite"; greedy = true; }
      { name = "keepingyouawake"; greedy = true; }
      { name = "logseq"; greedy = true; }
      { name = "morgen"; greedy = true; }
      { name = "quitter"; greedy = true; }
      { name = "rio"; greedy = true; }
      { name = "sf-symbols"; greedy = true; }
      { name = "signal@beta"; greedy = true; }
      { name = "tableplus"; greedy = true; }
      { name = "unnaturalscrollwheels"; greedy = true; }
      { name = "vlc"; greedy = true; }
      { name = "xquartz"; greedy = true; }
      { name = "zen-browser"; greedy = true; }
    ];
    masApps = {};
  };
} 