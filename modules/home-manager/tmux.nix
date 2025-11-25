{ config, pkgs, lib, ... }:

let colors = import ./colors.nix;
    arc = if colors ? arcBlueberry then colors.arcBlueberry else colors;
    tmuxExtraConfigBody =
      let
        body = builtins.readFile ./tmux/extra.conf;
      in lib.replaceStrings [
        "@BG@" "@FG@" "@YELLOW@" "@BLUE@" "@BRIGHT_BLACK@" "@MAGENTA@" "@GREEN@"
      ] [
        arc.background arc.foreground arc.normal.yellow arc.normal.blue arc.bright.black arc.normal.magenta arc.normal.green
      ] body;
in {
  programs.tmux = {
    enable = true;
    shell = "/opt/homebrew/bin/fish";
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
        extraConfig = builtins.readFile ./tmux/continuum.conf;
      }
    ];
    extraConfig = tmuxExtraConfigBody;
  };
}
