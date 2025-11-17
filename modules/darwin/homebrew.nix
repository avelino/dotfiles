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
      "mas"
      "sentry-cli"
      "ruff"
    ];

    casks = [
      "cursor"
      "visual-studio-code@insiders"
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
      "tailscale-app"
      "rio"
      "tor-browser"
      "google-chrome"
      "chatgpt"
      "notion-calendar"
      "raindropio"
      "rocket"
      "figma"
      "chatgpt-atlas"
      "roam-research"
      "cloudflare-warp"
    ];

    masApps = {
      "1Blocker" = 1365531024;
      "1Password for Safari" = 1569813296;
      "Bitwarden" = 1352778147;
      "Developer" = 640199958;
      "Ghostery Privacy Ad Blocker" = 6504861501;
      "LanguageTool" = 1534275760;
      "Raycast Companion" = 6738274497;
      "Simplify for Gmail" = 1544668450;
      "Todoist" = 585829637;
    };
  };
}
