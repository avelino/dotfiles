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
      "cocoapods"
      "imagemagick"
      "pandoc"
      "kubectl"
      "kubelogin"
      "poetry"
    ];

    casks = [
      "cursor"
      "morgen"
      "orbstack"
      "raycast"
      "logseq"
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
      "rio"
      "warp"
      "tor-browser"
      "google-chrome"
      "chatgpt"
    ];
  };
}
