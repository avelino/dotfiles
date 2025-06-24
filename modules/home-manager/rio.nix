{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.rio ];

  home.file.".config/rio/config.toml".text = let
    colors = import ./colors.nix;
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
    background = "${colors.background}"
    foreground = "${colors.foreground}"
  '';
}
