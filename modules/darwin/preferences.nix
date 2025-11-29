{ pkgs, lib, ... }:

let home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in {
  system.defaults.NSGlobalDomain = {
    # Keyboard and Input
    InitialKeyRepeat = 15;
    KeyRepeat = 2;
    ApplePressAndHoldEnabled = false;
    NSAutomaticCapitalizationEnabled = false;
    NSAutomaticDashSubstitutionEnabled = false;
    NSAutomaticPeriodSubstitutionEnabled = false;
    NSAutomaticQuoteSubstitutionEnabled = false;
    NSAutomaticSpellingCorrectionEnabled = false;

    # Mouse and Trackpad
    AppleEnableSwipeNavigateWithScrolls = true;

    # Visual and UI
    AppleShowScrollBars = "Automatic";
    NSWindowResizeTime = 1.0e-3;
    AppleFontSmoothing = 1;
    NSTableViewDefaultSizeMode = 1;
    AppleShowAllExtensions = true;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    AppleShowAllFiles = true;

    # Animation optimizations (faster webapp switching)
    NSAutomaticWindowAnimationsEnabled = false;
    AppleScrollerPagingBehavior = true;

    # System Behavior
    NSDocumentSaveNewDocumentsToCloud = false;
  };

  # Additional system defaults that need different paths
  system.defaults = {
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      FXEnableExtensionChangeWarning = false;
      CreateDesktop = false;
    };

    # Basic trackpad settings (nix-darwin supported options)
    trackpad = {
      Clicking = true;
      TrackpadRightClick = true;
      TrackpadThreeFingerDrag = true;
      ActuationStrength = 1;
    };
  };

  # Language and region settings via activation script
  system.activationScripts.extraUserSettings.text =
    let body = builtins.readFile ./darwin/extraUserSettings.sh;
    in lib.replaceStrings [ "@HOME@" ] [ home ] body;
}
