{ pkgs, ... }:

{
  # Dock settings
  system.defaults.dock = {
    # Auto-hide and show behavior
    autohide = true;
    autohide-delay = 0.0;
    autohide-time-modifier = 0.15;

    # Animation and visual settings (optimized for webapps)
    mineffect = "scale";
    minimize-to-application = true;
    mouse-over-hilite-stack = true;
    launchanim = false;

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
  # STEPS:
  # 1. `defaults read com.apple.dock > dock.json`
  # 2. read `dock.json` and convert to nix extraDockSettings
  system.activationScripts.extraDockSettings.text =
    builtins.readFile ./darwin/extraDockSettings.sh;
}
