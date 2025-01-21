{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.rio ];

  home.file.".config/rio/config.toml".text = ''
    performance = "High"
    height = 438
    width = 662
    padding-x = 10

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

    [fonts]
    family = "Maple Mono"
    size = 22

    [renderer]
    performance = "High"
    disable-unfocused-render = false

    [developer]
    enable-fps-counter = false
    log-level = 'INFO'
  '';
}
