{ pkgs, ... }:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
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
    NSWindowResizeTime = 0.001;
    AppleFontSmoothing = 1;
    NSTableViewDefaultSizeMode = 1;
    AppleShowAllExtensions = true;
    NSNavPanelExpandedStateForSaveMode = true;
    NSNavPanelExpandedStateForSaveMode2 = true;
    AppleShowAllFiles = true;

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
  system.activationScripts.extraUserSettings.text = ''
    # Setting up wallpaper directory and wallpaper
    mkdir -p ${home}/dotfiles/wallpapers
    if [ -f "${home}/dotfiles/wallpapers/sunrise.png" ]; then
      osascript -e 'tell application "Finder" to set desktop picture to POSIX file "${home}/dotfiles/wallpapers/sunrise.png"'
    fi

    # Setting language and region
    defaults write NSGlobalDomain AppleLanguages -array "en-BR"
    defaults write NSGlobalDomain AppleLocale -string "en_BR"
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    defaults write NSGlobalDomain AppleMetricUnits -bool true
    defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"

    # Night Shift settings
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.AutoBlueReductionEnabled -bool true
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.BlueReductionEnabled -bool true
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.BlueReductionMode -int 2
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.BlueLightReductionSchedule.DayStartHour -int 7
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.BlueLightReductionSchedule.DayStartMinute -int 0
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.BlueLightReductionSchedule.NightStartHour -int 22
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueReductionStatus.BlueLightReductionSchedule.NightStartMinute -int 0
    defaults write com.apple.CoreBrightness.plist CBUser-0.CBBlueLightReductionCCTTargetRaw -float 3458.715

    # Setting text replacement items
    defaults write NSGlobalDomain NSUserDictionaryReplacementItems -array \
      '{"on" = 1; "replace" = "sjc"; "with" = "SJC";}' \
      '{"on" = 1; "replace" = "blz"; "with" = "beleza";}' \
      '{"on" = 1; "replace" = "sgtm"; "with" = "SGTM";}' \
      '{"on" = 1; "replace" = "lgtm"; "with" = "LGTM";}' \
      '{"on" = 1; "replace" = "hpns"; "with" = "¯\\_(ツ)_/¯";}' \
      '{"on" = 1; "replace" = "omw"; "with" = "On my way!";}' \
      '{"on" = 1; "replace" = "aa"; "with" = "à";}' \
      '{"on" = 1; "replace" = "neh"; "with" = "né";}' \
      '{"on" = 1; "replace" = "et"; "with" = "é";}' \
      '{"on" = 1; "replace" = "eh"; "with" = "é";}' \
      '{"on" = 1; "replace" = "vcs"; "with" = "vocês";}' \
      '{"on" = 1; "replace" = "eac"; "with" = "Estou a caminho!";}' \
      '{"on" = 1; "replace" = "vvg"; "with" = "very very good!";}' \
      '{"on" = 1; "replace" = "omg"; "with" = "Oh my good!";}' \
      '{"on" = 1; "replace" = "omw"; "with" = "On my way";}'

    # Additional UI settings
    defaults write NSGlobalDomain AppleAntiAliasingThreshold -int 4
    defaults write NSGlobalDomain AppleHighlightColor -string "0.698039 0.843137 1.000000 Blue"
    defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
    defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
    defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false
    defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false
    defaults write NSGlobalDomain _HIHideMenuBar -bool true
    defaults write NSGlobalDomain "com.apple.mouse.scaling" -float 2.5
    defaults write NSGlobalDomain "com.apple.mouse.tapBehavior" -int 1
    defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 1.5
    defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -bool true
    defaults write NSGlobalDomain "com.apple.swipescrolldirection" -bool true
    defaults write NSGlobalDomain "com.apple.springing.enabled" -bool true
    defaults write NSGlobalDomain "com.apple.springing.delay" -float 0
    defaults write NSGlobalDomain "com.apple.sound.beep.flash" -bool false

    # Advanced trackpad settings
    defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadHandResting -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadHorizScroll -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadMomentumScroll -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadPinch -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRotate -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadScroll -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerTapGesture -bool false
    defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
    defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerDoubleTapGesture -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
    defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
    defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1

    # Bluetooth trackpad settings
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHandResting -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadHorizScroll -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadMomentumScroll -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadPinch -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRotate -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadScroll -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -bool false
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerDoubleTapGesture -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadTwoFingerFromRightEdgeSwipeGesture -int 3
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad FirstClickThreshold -int 1
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad SecondClickThreshold -int 1
  '';
}
