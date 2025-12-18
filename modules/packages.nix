# Central package definitions - single source of truth
# Used by:
#   - modules/darwin/homebrew.nix (Darwin via Homebrew)
#   - modules/home-manager/packages.nix (Linux via Nix)
#   - modules/home-manager/neovim.nix (editor-specific extras)
{
  # Homebrew taps required for some packages
  taps = [
    "borkdude/brew"
    "oven-sh/bun"
    "clojure/tools"
    "clojure-lsp/brew"
    "nikitabobko/tap"
  ];

  # ============================================================================
  # CLI packages (brews)
  # ============================================================================

  # DevOps & cloud tooling
  devops = [
    "act"
    "ansible"
    "argocd"
    "awscli"
    "kubectl"
    "kubectx"
    "kubelogin"
    "sentry-cli"
    "stern"
    "terraform-ls"
    "tflint"
  ];

  # Languages, runtimes & package managers
  languages = {
    # Packages with special tap prefixes (Homebrew only)
    brewOnly = [
      "borkdude/brew/babashka"
      "clojure/tools/clojure"
      "oven-sh/bun/bun"
    ];
    # Standard packages (work on both Homebrew and Nix)
    common = [
      "go"
      "node"
      "yarn"
    ];
    # Darwin-specific (version managers, etc)
    darwinOnly = [
      "nodenv"
      "nvm"
      "poetry"
      "python@3.13"
      "rustup-init"
      "uv"
    ];
    # Nix equivalents for Linux
    nixEquivalents = {
      "borkdude/brew/babashka" = "babashka";
      "clojure/tools/clojure" = "clojure";
      "oven-sh/bun/bun" = "bun";
      "node" = "nodejs";
    };
  };

  # Build systems, compilers & debuggers
  buildTools = [
    "cmake"
    "cocoapods"
    "delve"
    "llvm"
  ];

  # Language servers, formatters & linters
  lsp = {
    # Available in both Homebrew and Nix
    common = [
      "bash-language-server"
      "dockerfile-language-server"
      "gofumpt"
      "lua-language-server"
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
      "yaml-language-server"
      "yamllint"
      "zls"
    ];
    # Homebrew-specific names/taps
    brewOnly = [
      "clojure-lsp/brew/clojure-lsp-native"
      "nixfmt"
    ];
    # Nix equivalents
    nixEquivalents = {
      "clojure-lsp/brew/clojure-lsp-native" = "clojure-lsp";
      "dockerfile-language-server" = "dockerfile-language-server-nodejs";
      "nixfmt" = "nixfmt-classic";
    };
    # Nix-only LSPs (not in Homebrew or better via Nix)
    nixOnly = [
      "nil" # Nix LSP - prefer nix version
      "clang-tools"
    ];
  };

  # CLI essentials & shell UX
  cli = [
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
    "nvim"
    "pandoc"
    "ripgrep"
    "the_silver_searcher"
    "yq"
  ];

  # Documentation & content pipelines
  docs = [
    "hugo"
  ];

  # ============================================================================
  # GUI applications (casks) - Darwin only
  # ============================================================================
  casks = {
    security = [
      "1password"
      "1password-cli"
      "cloudflare-warp"
      "ngrok"
      "tailscale-app"
      "tor-browser"
    ];

    windowManagement = [
      "nikitabobko/tap/aerospace"
      "orbstack"
      "rio"
    ];

    development = [
      "cursor"
      "visual-studio-code"
      "visual-studio-code@insiders"
      "claude-code"
      "headlamp"
      "tableplus"
      "zed@preview"
      "antigravity"
    ];

    browsers = [
      "arc"
      "google-chrome"
    ];

    communication = [
      "chatgpt-atlas"
      "slack"
      "whatsapp"
      "spotify"
    ];

    productivity = [
      "chatgpt"
      "claude"
      "logseq"
      "notion-calendar"
      "raindropio"
      "raycast"
      "rocket"
      "roam-research"
      "karabiner-elements"
    ];

    design = [
      "figma"
      "font-fontawesome"
      "font-maple-mono"
      "graalvm-jdk@17"
      "domzilla-caffeine"
      "unnaturalscrollwheels"
    ];
  };

  # ============================================================================
  # Neovim-specific packages (not installed globally)
  # These are only needed inside Neovim and shouldn't pollute global PATH
  # ============================================================================
  neovimOnly = [
    "pyright"
    "rust-analyzer"
    "black"
    "rustfmt"
  ];
}
