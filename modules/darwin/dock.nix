{ pkgs, ... }:

{
  # Dock settings
  system.defaults.dock = {
    # Auto-hide and show behavior
    autohide = true;
    
    # Animation and visual settings
    mineffect = "scale";
    minimize-to-application = true;
    mouse-over-hilite-stack = true;
    
    # Size and magnification
    largesize = 44;
    tilesize = 22;
    magnification = true;
    
    # Location and orientation
    orientation = "left";
    
    # Spaces and window management
    mru-spaces = false;
    
    # Show indicators and recents
    show-process-indicators = true;
    show-recents = false;
    showhidden = true;
  };

  # Additional Dock settings via activation script
  system.activationScripts.extraDockSettings.text = ''
    echo "Configuring additional Dock settings..."
    
    # Auto-hide delay and animation time
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0
    
    # Animation settings
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dock springboard-show-duration -int 0
    defaults write com.apple.dock springboard-hide-duration -int 0
    defaults write com.apple.dock expose-group-by-app -bool false
    defaults write com.apple.dock launchanim -bool false

    # Setting up dock items
    # Clear all persistent apps first
    defaults write com.apple.dock persistent-apps -array

    # Add Zen Browser
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/Zen%20Browser.app/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Zen Browser</string><key>bundle-identifier</key><string>app.zen-browser.zen</string></dict></dict>'

    # Clear all persistent others first
    defaults write com.apple.dock persistent-others -array

    # Add Downloads folder
    defaults write com.apple.dock persistent-others -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/avelino/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Downloads</string><key>arrangement</key><integer>2</integer><key>displayas</key><integer>0</integer><key>showas</key><integer>1</integer></dict></dict>'

    # Setting up hot corners
    # Bottom left - Start Screen Saver
    defaults write com.apple.dock wvous-bl-corner -int 1
    defaults write com.apple.dock wvous-bl-modifier -int 1048576

    # Bottom right - Start Screen Saver
    defaults write com.apple.dock wvous-br-corner -int 1
    defaults write com.apple.dock wvous-br-modifier -int 1048576

    # Top left - Start Screen Saver
    defaults write com.apple.dock wvous-tl-corner -int 1
    defaults write com.apple.dock wvous-tl-modifier -int 1048576

    # Top right - Mission Control
    defaults write com.apple.dock wvous-tr-corner -int 2
    defaults write com.apple.dock wvous-tr-modifier -int 0

    # Restart Dock to apply changes
    killall Dock
  '';
} 