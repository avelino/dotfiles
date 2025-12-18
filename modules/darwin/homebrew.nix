{ ... }:
let
  packages = import ../packages.nix;

  # Flatten all brew packages from central definition
  allBrews = packages.devops
    ++ packages.languages.brewOnly
    ++ packages.languages.common
    ++ packages.languages.darwinOnly
    ++ packages.buildTools
    ++ packages.lsp.common
    ++ packages.lsp.brewOnly
    ++ packages.cli
    ++ packages.docs;

  # Flatten all casks
  allCasks = packages.casks.security
    ++ packages.casks.windowManagement
    ++ packages.casks.development
    ++ packages.casks.browsers
    ++ packages.casks.communication
    ++ packages.casks.productivity
    ++ packages.casks.design;
in
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    global = {
      brewfile = true;
      lockfiles = true;
    };

    taps = packages.taps;
    brews = allBrews;
    casks = allCasks;
  };
}
