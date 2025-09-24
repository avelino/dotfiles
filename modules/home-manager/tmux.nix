{ config, pkgs, lib, ... }:

let colors = import ./colors.nix;
    mpr = colors.monokaiProRistretto;
    tmuxExtraConfigBody =
      let
        body = builtins.readFile ./tmux/extra.conf;
      in lib.replaceStrings [
        "@BG@" "@FG@" "@YELLOW@" "@BLUE@" "@BRIGHT_BLACK@" "@MAGENTA@" "@GREEN@"
      ] [
        mpr.background mpr.foreground mpr.normal.yellow mpr.normal.blue mpr.bright.black mpr.normal.magenta mpr.normal.green
      ] body;
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
        extraConfig = builtins.readFile ./tmux/continuum.conf;
      }
    ];
    extraConfig = tmuxExtraConfigBody;
  };
}
