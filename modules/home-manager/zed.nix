{ pkgs, ... }:
{
  xdg.configFile."zed/settings.json" = {
    text = builtins.toJSON ({
      vim_mode = false;
      autosave = "on_focus_change";
      ui_font_size = 16;
      buffer_font_size = 16;
      theme = {
        mode = "dark";
        light = "Tokyo Night Light";
        dark = "Tokyo Night";
      };
      assistant = {
        default_model = {
          provider = "anthropic";
          model = "claude-3-5-sonnet-20240620";
        };
        provider = {
          name = "anthropic";
          default_model = "claude-3-5-sonnet";
        };
        version = "1";
        dock = "right";
        enabled = true;
      };
      auto_indent = true;
      enabled = true;
      show_on_startup = true;
      default_model = {
        model = "en_core_web_sm";
        provider = "zed.dev";
      };
      enable_experimental_live_diffs = true;
      button = true;
      terminal = {
        shell = "${pkgs.fish}/bin/fish";
        shell_args = ["-l"];
        shell_env = {
          LANG = "en_US.UTF-8";
          LC_ALL = "en_US.UTF-8";
        };
      };
    });
  };
}
