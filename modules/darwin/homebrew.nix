{ ... }:

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

    brews = [
      "nvm"
      "nodenv"
      "gnupg"
      "python@3.13"
    ];

    casks = [
      "cursor"
      "morgen"
      "orbstack"
      "raycast"
      "logseq"
      "zen-browser"
      "1password"
      "1password-cli"
      "font-maple-mono"
      "zed@preview"
      "domzilla-caffeine"
      "slack"
      "ngrok"
      "tableplus"
      "spotify"
      "tailscale"
      "whatsapp"
    ];
  };
}
