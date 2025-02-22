{ pkgs, ... }:

{
  # Homebrew configuration
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

    casks = [
      "cursor"
      "windsurf"
      "morgen"
      "orbstack"
      "raycast"
      "zen-browser"
      "1password"
      "1password-cli"
      "font-maple-mono"
      "zed"
      "orion" # browser by webkit
    ];
  };
}
