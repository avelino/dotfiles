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

    taps = [
      "oven-sh/bun"
    ];

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
      "uv"
      "oven-sh/bun/bun"
      "awscli"
    ];

    casks = [
      "cursor"
      # "morgen" # TODO: remove this, I'm not using anymore
      "orbstack"
      "raycast"
      "logseq"
      "1password"
      "1password-cli"
      "font-maple-mono"
      "zed@preview"
      "domzilla-caffeine"
      "slack"
      "tableplus"
      "spotify"
      "ngrok"
      "rio"
      "tor-browser"
      "google-chrome"
      "chatgpt"
      "notion-mail"
      "notion-calendar"
    ];
  };
}
