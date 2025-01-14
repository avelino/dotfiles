{ pkgs, ... }:

{
  # Import modules
  imports = [
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/tmux.nix
    ../../modules/rio.nix
  ];

  # DNS configuration for macOS
  networking = {
    knownNetworkServices = ["Wi-Fi" "Ethernet"];
    dns = [
      "9.9.9.9"    # Quad9 DNS
      "1.1.1.1"    # Cloudflare DNS
      "8.8.8.8"    # Google DNS
    ];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # Terminal and Shell utilities
    eza
    rio
    direnv
    curl
    fzf
    htop
    less
    mosh
    xclip

    # System and File utilities
    age
    comma
    cosign
    entr
    fd
    gnumake
    go-task
    graphviz
    httpstat
    hyperfine
    moreutils
    ncdu
    netcat-gnu
    nmap
    onefetch
    p7zip
    ripgrep
    scc
    sqlite
    tldr
    unixtools.watch
    unrar
    vegeta
    wget

    # Development
    ## Languages and Runtimes
    go
    nodejs
    yarn
    rustc
    cargo
    rustfmt
    rust-analyzer
    clojure
    zig

    ## Development Tools
    jq
    d2
    babashka
    clj-kondo

    # Kubernetes and Cloud
    kubectl
    kubectx
    stern
    argocd

    # Applications
    logseq
    spotify

    # Language Servers and Development Tools
    bash-language-server
    clang-tools # clangd lsp
    clojure-lsp
    delve
    dockerfile-language-server-nodejs
    gofumpt
    htmx-lsp
    nil # nix lsp
    nixfmt-rfc-style
    pgformatter
    rustup
    shellcheck
    shfmt
    stylua
    sumneko-lua-language-server
    tailwindcss-language-server
    taplo # toml lsp
    terraform-ls
    tflint
    tree-sitter
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
    yamllint
    zls # zig lsp

    # Fonts
    maple-mono
    font-awesome
  ];

  # System state version
  system.stateVersion = 4;

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

    taps = ["homebrew/cask"];
    
    casks = [
      "cursor"
      "morgen"
      "orbstack"
      "raycast"
      "zen-browser"
      "1password"
      "1password-cli"
    ];
  };
} 
