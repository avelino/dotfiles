{ pkgs, ... }:
{
  home.file.".config/zed/settings.json".text = builtins.toJSON ({
    vim_mode = true;
    autosave = true;
    ui_font_size = 16;
    buffer_font_size = 16;
    theme = {
      mode = "dark";
      light = "Rosé Pine Dawn";
      dark = "Rosé Pine";
    };
    assistant = true;
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
}
