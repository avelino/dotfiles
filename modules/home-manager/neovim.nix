{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # Language servers
      clojure-lsp
      pyright
      rust-analyzer
      nil # Nix LSP
      nodePackages_latest.bash-language-server

      # Tools
      ripgrep
      fd
      tree-sitter
      nodejs # Required for Copilot

      # Formatters and linters
      black
      ruff
      # ruff-lsp
      nixfmt-classic
      rustfmt
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua/plugins/lang.lua".source = ./nvim/lua/plugins/lang.lua;
    "nvim/lua/plugins/lsp.lua".source = ./nvim/lua/plugins/lsp.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ./nvim/lua/config/keymaps.lua;
  };
}
