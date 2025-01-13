{ config, lib, pkgs, ... }: {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      # Open Rio
      cmd + shift - return : open --new -a /Applications/Rio.app/Contents/MacOS/rio

      # Minimize window
      cmd - m: yabai -m window --minimize && yabai -m window --focus prev || yabai -m window --focus first

      # Change tilling layout
      cmd - e : yabai -m space --layout bsp
      cmd - s : yabai -m space --layout stack

      # Focus window [north|south|west|east], support multiple monitors
      cmd - j : yabai -m window --focus stack.next || \
                     yabai -m window --focus south || \
                     yabai -m window --focus $(yabai -m query --windows --display south | \
                                               jq 'map(select(.visible == 1)) | sort_by(.frame.x, .frame.y) | last | .id') || \
                     yabai -m display --focus south

      cmd - [ : yabai -m window --focus west || \
                     yabai -m window --focus $(yabai -m query --windows --display west | \
                                               jq 'map(select(.visible == 1)) | sort_by(.frame.x, .frame.y) | last | .id') || \
                     yabai -m display --focus west

      cmd - ] : yabai -m window --focus east || \
                     yabai -m window --focus $(yabai -m query --windows --display east | \
                                               jq 'map(select(.visible == 1)) | sort_by(.frame.x, .frame.y) | first | .id') || \
                     yabai -m display --focus east

      # Focus in spaces
      cmd + shift - 1 : yabai -m window --space 1; yabai -m space --focus 1
      cmd + shift - 2 : yabai -m window --space 2; yabai -m space --focus 2
      cmd + shift - 3 : yabai -m window --space 3; yabai -m space --focus 3

      # Workspace navigate
      ctrl + alt - 1 :yabai -m query --spaces --space 1 | jq -r '.windows[0] // empty' | xargs yabai -m window --focus
      ctrl + alt - 2 :yabai -m query --spaces --space 2 | jq -r '.windows[0] // empty' | xargs yabai -m window --focus
      ctrl + alt - 3 :yabai -m query --spaces --space 3 | jq -r '.windows[0] // empty' | xargs yabai -m window --focus

      # Restart yabai
      cmd + lctrl - r : \
          /usr/bin/env osascript <<< \
              "display notification \"Restarting Yabai\" with title \"Yabai\""; \
          launchctl kickstart -k "gui/${UID}/homebrew.mxcl.yabai"

      # Space navigation
      ctrl + alt - n : yabai -m space --focus next
      ctrl + alt - p : yabai -m space --focus previous
    '';
  };
} 