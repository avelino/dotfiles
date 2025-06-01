{
  config,
  lib,
  ...
}:
{
  # Create necessary directories and link .zed to config
  home.activation.setupZedConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${config.home.homeDirectory}/.zed"
    ln -sfn "${config.home.homeDirectory}/dotfiles/modules/home-manager/zed/settings.json" "${config.home.homeDirectory}/.zed/settings.json"
    ln -sfn "${config.home.homeDirectory}/dotfiles/modules/home-manager/zed/keymap.json" "${config.home.homeDirectory}/.zed/keymap.json"
  '';
}
