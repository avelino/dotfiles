{ pkgs, ... }:

{
  # Install tmux package
  environment.systemPackages = [ pkgs.tmux ];

  # Create tmux configuration file
  environment.etc."tmux.conf".text = ''
    # Set Fish as default shell
    set-option -g default-shell ${pkgs.fish}/bin/fish

    # Set prefix key to C-q instead of default C-b
    unbind C-b
    set -g prefix C-q
    bind C-q send-prefix

    # Terminal settings
    set -g default-terminal "screen-256color"
    set -ga terminal-overrides ",xterm-256color:Tc"

    # Start windows and pane numbering with index 1 instead of 0
    set -g base-index 1
    setw -g pane-base-index 1

    # Re-number windows when one is closed
    set -g renumber-windows on

    # Disable activity monitoring
    setw -g monitor-activity off
    set -g visual-activity off

    # Show times longer than supposed
    set -g display-panes-time 2000

    # Split horiziontal and vertical splits
    bind | split-window -h
    bind _ split-window -v

    # Move windows with Ctrl+Shift+Left/Right
    bind-key -n C-S-Left swap-window -t -1
    bind-key -n C-S-Right swap-window -t +1

    # Reload config file
    unbind r
    bind r source-file /etc/tmux.conf \; display "Reloaded!"

    # Use vi keybindings in copy mode
    setw -g mode-keys vi
    set -g status-keys emacs

    # Faster command sequence
    set -s escape-time 0

    # Large history limit
    set -g history-limit 1000000

    # Mouse mode off
    set -g mouse off

    # Set title
    set -g set-titles on
    set -g set-titles-string "#T"

    # Layout bindings
    bind-key = select-layout even-horizontal
    bind-key | select-layout even-vertical

    # Resize panes
    bind-key J resize-pane -D 5
    bind-key K resize-pane -U 5
    bind-key H resize-pane -L 5
    bind-key L resize-pane -R 5

    # Vim-style pane navigation
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # Disable confirm before killing
    bind-key x kill-pane

    # Disable suspend
    unbind-key C-z

    # Window switching with Shift+Arrow
    bind-key -n S-Left previous-window
    bind-key -n S-Right next-window

    # TPM plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-sidebar'
    set -g @plugin 'rose-pine/tmux'

    # Rose Pine theme configuration
    set -g @rose_pine_variant 'main'
    set -g @rose_pine_bar_bg_disable 'on'

    # Initialize TPM
    run '~/.tmux/plugins/tpm/tpm'
  '';

  # Install TPM and plugins
  system.activationScripts.tmux.text = ''
    # Create tmux plugin directory
    mkdir -p ~/.tmux/plugins
    
    # Install TPM if not present
    if [ ! -d ~/.tmux/plugins/tpm ]; then
      git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi
  '';
} 