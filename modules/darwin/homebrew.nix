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
      "clojure/tools"
      "clojure-lsp/brew"
      "nikitabobko/tap"
    ];

    brews = [
      # --- DevOps & cloud tooling ---
      "act"
      "argocd"
      "awscli"
      "kubectl"
      "kubectx"
      "kubelogin"
      "sentry-cli"
      "stern"
      "terraform-ls"
      "tflint"

      # --- Languages, runtimes & package managers ---
      "clojure/tools/clojure"
      "go"
      "node"
      "nodenv"
      "nvm"
      "oven-sh/bun/bun"
      "poetry"
      "python@3.13"
      "rustup-init"
      "uv"
      "yarn"

      # --- Build systems, compilers & debuggers ---
      "cmake"
      "cocoapods"
      "delve"
      "llvm"

      # --- Language servers, formatters & linters ---
      "bash-language-server"
      "clojure-lsp/brew/clojure-lsp-native"
      "dockerfile-language-server"
      "gofumpt"
      "lua-language-server"
      "nixfmt"
      "pgformatter"
      "ruff"
      "shellcheck"
      "shfmt"
      "stylua"
      "tailwindcss-language-server"
      "taplo"
      "tree-sitter"
      "typescript-language-server"
      "vscode-langservers-extracted"
      "yamllint"
      "yaml-language-server"
      "zls"

      # --- CLI essentials & shell UX ---
      "bat"
      "btop"
      "curl"
      "d2"
      "direnv"
      "eza"
      "fd"
      "fish"
      "fzf"
      "gh"
      "git"
      "git-delta"
      "gnupg"
      "htop"
      "imagemagick"
      "jq"
      "ripgrep"
      "the_silver_searcher"
      "yq"

      # --- Documentation & content pipelines ---
      "hugo"
      "pandoc"
    ];

    casks = [
      # --- Security & networking ---
      "1password"
      "1password-cli"
      "cloudflare-warp"
      "ngrok"
      "tailscale-app"
      "tor-browser"

      # --- Window management, virtualization & terminals ---
      "nikitabobko/tap/aerospace"
      "orbstack"
      "rio"

      # --- Developer workstations ---
      "cursor"
      "headlamp"
      "tableplus"
      "visual-studio-code@insiders"
      "zed@preview"
      "antigravity"

      # --- Browsers & communication ---
      "arc"
      "google-chrome"
      "chatgpt-atlas"
      "slack"
      "spotify"

      # --- Knowledge & productivity ---
      "chatgpt"
      "logseq"
      "notion-calendar"
      "raindropio"
      "raycast"
      "rocket"
      "roam-research"
      "karabiner-elements"

      # --- Design, fonts & creative tools ---
      "figma"
      "font-fontawesome"
      "font-maple-mono"
      "graalvm-jdk@17"
      "domzilla-caffeine"
      "unnaturalscrollwheels"
    ];
  };
}
