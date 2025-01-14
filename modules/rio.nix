{ pkgs, ... }:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
  # Install Rio terminal
  environment.systemPackages = [ pkgs.rio ];

  # Create Rio configuration directory and file
  environment.etc."rio/config.toml".text = ''
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
    args = ["new-session", "-c", "${home}"]

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

  # Create Rio config directory and link configuration
  system.activationScripts.postActivation.text = ''
    echo "Setting up Rio configuration..."
    
    # Create Rio config directory
    mkdir -p ${home}/.config/rio
    
    # Link configuration file
    rm -f ${home}/.config/rio/config.toml
    ln -sf /etc/rio/config.toml ${home}/.config/rio/config.toml
    
    # Set correct permissions
    chown -R avelino:staff ${home}/.config/rio
  '';
} 