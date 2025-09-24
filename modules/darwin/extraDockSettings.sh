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

# Add Arc Browser
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///nix/store/g9hm4sccxcwwnk58hd5kf0jkndffr7l4-arc-browser-1.77.0-57419/Applications/Arc.app/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Arc</string><key>bundle-identifier</key><string>company.thebrowser.Browser</string></dict></dict>'

# Add Morgen
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/Morgen.app/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Morgen</string><key>bundle-identifier</key><string>com.todesktop.210203cqcj00tw1</string></dict></dict>'

# Add Logseq
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///nix/store/rc2gq0kbf9h6k9v500b474kk4jc0npfa-logseq-0.10.9/Applications/Logseq.app/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Logseq</string><key>bundle-identifier</key><string>com.electron.logseq</string></dict></dict>'

# Add Rio
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///nix/store/j32iiw21g2ns168c19l7cl9ir65b4ir3-rio-0.1.17/Applications/Rio.app/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Rio</string><key>bundle-identifier</key><string>com.raphaelamorim.rio</string></dict></dict>'

# Add Cursor
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/Cursor.app/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Cursor</string><key>bundle-identifier</key><string>com.todesktop.230313mzl4w4u92</string></dict></dict>'

# Clear all persistent others first
defaults write com.apple.dock persistent-others -array

# Add Downloads folder
defaults write com.apple.dock persistent-others -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/avelino/Downloads/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>Downloads</string><key>arrangement</key><integer>2</integer><key>displayas</key><integer>0</integer><key>showas</key><integer>1</integer></dict></dict>'

# Setting up hot corners
# Bottom right - Start Screen Saver
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0

# Top right - Mission Control
defaults write com.apple.dock wvous-tr-corner -int 2
defaults write com.apple.dock wvous-tr-modifier -int 0

# Restart Dock to apply changes
killall Dock


