{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Create necessary directories and link .cursor/rules to MDC
  home.activation.setupCursorRules = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if [ ! -d "${config.home.homeDirectory}/.cursor/rules" ]; then
      mkdir -p "${config.home.homeDirectory}/.cursor"
      ln -sfn "${config.home.homeDirectory}/dotfiles/modules/home-manager/mdc" "${config.home.homeDirectory}/.cursor/rules"
    fi
  '';
}
