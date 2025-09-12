{ config, pkgs, lib, ... }:

{
  # home.packages = [ pkgs.rio ];

  home.file.".config/rio/config.toml".text = let
    colors = import ./colors.nix;
    mpr = colors.monokaiProRistretto;
  in ''
    performance = "High"
    height = 438
    width = 662
    padding-x = 10
    close-on-quit = true

    # theme = "dracula"
    # theme = "rose-pine"
    option-as-alt = 'both'

    [editor]
    program = "cursor"
    args = []

    [keyboard]
    use-kitty-keyboard-protocol = false
    disable-ctlseqs-alt = false

    [shell]
    program = "${pkgs.tmux}/bin/tmux"
    args = ["new-session", "-A", "-s", "main", "-c", "$HOME"]

    [navigation]
    mode = "Plain"

    [window]
    height = 438
    width = 662
    mode = "Fullscreen"
    opacity = 1.0
    blur = false
    decorations = "Buttonless"

    [fonts]
    family = "Maple Mono"
    size = 22

    [renderer]
    performance = "High"
    disable-unfocused-render = false

    [developer]
    enable-fps-counter = false
    log-level = 'INFO'

    [colors]
    background = "${mpr.background}"
    foreground = "${mpr.foreground}"
    black = "${mpr.normal.black}"
    red = "${mpr.normal.red}"
    green = "${mpr.normal.green}"
    yellow = "${mpr.normal.yellow}"
    blue = "${mpr.normal.blue}"
    magenta = "${mpr.normal.magenta}"
    cyan = "${mpr.normal.cyan}"
    white = "${mpr.normal.white}"
  '';
}
