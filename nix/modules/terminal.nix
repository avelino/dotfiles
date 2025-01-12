{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    terminal = "screen-256color";
    extraConfig = ''
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Reload config file
      bind r source-file ~/.tmux.conf \; display "Reloaded!"

      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Enable vi mode
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel
    '';
  };
} 