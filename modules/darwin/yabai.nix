{ config, lib, pkgs, ... }:

{
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = false;
    config = {
      # Mouse configs
      mouse_follows_focus = "on";
      focus_follows_mouse = "autofocus";
      mouse_modifier = "fn";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";

      # Window configs
      window_origin_display = "cursor";
      window_placement = "second_child";
      window_zoom_persist = "off";
      window_topmost = "off";
      window_shadow = "float";
      window_opacity = "on";
      window_opacity_duration = 0.0;
      active_window_opacity = 1.0;
      normal_window_opacity = 0.8;
      window_border = "off";
      window_border_width = 6;
      active_window_border_color = "0xff775759";
      normal_window_border_color = "0xff555555";
      insert_feedback_color = "0xffd75f5f";

      # General space settings
      layout = "bsp";
      split_ratio = 0.50;
      auto_balance = "off";
      top_padding = 10;
      bottom_padding = 10;
      left_padding = 10;
      right_padding = 10;
      window_gap = 5;

      external_bar = "all:26:0";
    };

    extraConfig = ''
      # space settings
      yabai -m rule --add app="^Arc|Zen Browser|Google Chrome|Firefox$" space=1
      yabai -m rule --add app="^(Zed|Zed Preview|Code|RStudio)$" space=2
      yabai -m rule --add app="^(Rio)$" space=2
      yabai -m rule --add app="^(Spotify)$" space=3

      # apps to not manage (ignore)
      yabai -m rule --add app='^System Information$' manage=off
      yabai -m rule --add app='^System Preferences$' manage=off
      yabai -m rule --add app='System Settings' manage=off
      yabai -m rule --add title='Preferences$' manage=off
      yabai -m rule --add title='Settings$' manage=off
      yabai -m rule --add app='Settings$' manage=off
      yabai -m rule --add app='1Password' manage=off
      yabai -m rule --add app='Raycast' manage=off
      yabai -m rule --add app='Morgen' manage=off
      yabai -m rule --add app='^Signal' manage=off
      yabai -m rule --add app='Simulator' manage=off
      yabai -m rule --add app='App Store' manage=off

      # Signal to restart yabai when Dock is restarted
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
    '';
  };

  # Ensure yabai starts after login
  launchd.user.agents.yabai = {
    serviceConfig = {
      StandardOutPath = "/tmp/yabai.out.log";
      StandardErrorPath = "/tmp/yabai.err.log";
      KeepAlive = true;
      RunAtLoad = true;
    };
  };
} 