{ config, pkgs, lib, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "screen-256color";
    historyLimit = 1000000;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    mouse = false;
    prefix = "C-q";
    extraConfig = ''
      # Terminal settings
      set -ga terminal-overrides ",xterm-256color:Tc"

      # Start pane numbering with index 1
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
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Set status-keys to emacs
      set -g status-keys emacs

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
    '';

    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      sidebar
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_bar_bg_disable 'on'
        '';
      }
    ];
  };
}