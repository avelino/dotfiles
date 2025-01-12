{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    prefix = "C-q";
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 1000000;
    keyMode = "vi";
    mouse = false;
    terminal = "tmux-256color";
    extraConfig = ''
      # re-number windows when one is closed
      set -g renumber-windows on

      # highlight window when it has new activity
      setw -g monitor-activity off
      set -g visual-activity off

      # Show times longer than supposed
      set -g display-panes-time 2000

      # Split horiziontal and vertical splits
      bind | split-window -h
      bind _ split-window -v

      # Pressing Ctrl+Shift+Left/Right to move windows
      bind-key -n C-S-Left swap-window -t -1
      bind-key -n C-S-Right swap-window -t +1

      # Source file
      unbind r
      bind r source-file ~/.tmux.conf \; display "Reloaded!"

      # Use emacs keybindings in copy mode
      bind-key -T copy-mode Enter send-keys -X copy-pipe-and-cancel "pbcopy"
      set -g status-keys emacs

      # Set title
      set -g set-titles on
      set -g set-titles-string "#T"

      # Equally resize all panes
      bind-key = select-layout even-horizontal
      bind-key | select-layout even-vertical

      # Resize panes
      bind-key J resize-pane -D 5
      bind-key K resize-pane -U 5
      bind-key H resize-pane -L 5
      bind-key L resize-pane -R 5

      # hjkl pane traversal
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Disable confirm before killing
      bind-key x kill-pane

      # disable M-a C-z to suspend tmux
      unbind-key C-z
      # disable C-d to exit shell
      unbind-key C-d

      # window switching with page up/down
      bind-key -n S-Left previous-window
      bind-key -n S-Right next-window
    '';
    plugins = with pkgs.tmuxPlugins; [
      sensible
      resurrect
      {
        plugin = rose-pine;
        extraConfig = ''
          set -g @rose_pine_variant 'main'
          set -g @rose_pine_bar_bg_disable 'on'
        '';
      }
      sidebar
    ];
  };
} 