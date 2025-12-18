{ pkgs, ... }:
let
  packages = import ../packages.nix;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;

    # Only Neovim-specific packages not installed globally
    # LSPs/formatters are already in Homebrew (Darwin) or packages.nix (Linux)
    extraPackages = with pkgs;
      map (name: pkgs.${name}) packages.neovimOnly;
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua/plugins/lang.lua".source = ./nvim/lua/plugins/lang.lua;
    "nvim/lua/plugins/lsp.lua".source = ./nvim/lua/plugins/lsp.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ./nvim/lua/config/keymaps.lua;
  };
}
