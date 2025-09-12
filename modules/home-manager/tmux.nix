{ config, pkgs, lib, ... }:

let colors = import ./colors.nix;
    mpr = colors.monokaiProRistretto;
in {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";
    historyLimit = 1000000;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    mouse = false;
    prefix = "C-q";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      # Set default config file path
      set-environment -g TMUX_CONFIG_DIR ~/.config/tmux
      set-environment -g XDG_CONFIG_HOME ~/.config

      # Terminal settings
      set -ga terminal-overrides ",*:Tc"
      set -as terminal-features "tmux-256color:RGB,xterm-256color:RGB"
      set -ga update-environment "EZA_COLORS"
      set -g set-clipboard on

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

      # colors (Monokai Pro - Filter Ristretto)
      set -g status-style "bg=${mpr.background},fg=${mpr.foreground}"
      # Ensure truecolor-aware apps behave the same inside tmux
      set-environment -g COLORTERM "truecolor"
      # Pass eza color theme to panes
      set-environment -g EZA_COLORS "di=38;2;255;149;92:ln=38;2;120;220;232:ex=38;2;169;220;118:fi=38;2;252;252;250:or=38;2;255;97;136"
      set -g message-style "bg=${mpr.background},fg=${mpr.normal.yellow}"
      set -g message-command-style "bg=${mpr.background},fg=${mpr.normal.blue}"
      set -g pane-border-style "fg=${mpr.bright.black}"
      set -g pane-active-border-style "fg=${mpr.normal.blue}"
      set -g mode-style "bg=${mpr.normal.magenta},fg=${mpr.background}"
      set -g status-left-length 40
      set -g status-right-length 120
      set -g status-left "#[fg=${mpr.normal.green},bold] #S "
      set -g status-right "#[fg=${mpr.normal.yellow}] %Y-%m-%d %H:%M #[fg=${mpr.foreground}] #H "
    '';
  };
}
