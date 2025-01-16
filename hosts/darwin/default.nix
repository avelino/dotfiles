{ pkgs, ... }:

{
  # Import modules
  imports = [
    ../../modules/darwin/preferences.nix
    ../../modules/darwin/dock.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/yabai.nix
    ../../modules/shell.nix
    ../../modules/git.nix
    ../../modules/tmux.nix
    ../../modules/rio.nix
    ../../modules/logseq.nix
    ../../modules/curl.nix
    ../../modules/clojure.nix
  ];

  # Define system state version (required)
  system.stateVersion = 5;

  # Ensure 1Password is always running
  launchd.user.agents."1password" = {
    serviceConfig = {
      Program = "/Applications/1Password.app/Contents/MacOS/1Password";
      KeepAlive = true;
      RunAtLoad = true;
      StandardOutPath = "/tmp/1password.out.log";
      StandardErrorPath = "/tmp/1password.err.log";
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    # environment
    yabai
    skhd

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
    zig

    ## Development Tools
    jq
    d2

    # Kubernetes and Cloud
    kubectl
    kubectx
    stern
    argocd

    # Applications
    # logseq
    spotify

    # Language Servers and Development Tools
    bash-language-server
    clang-tools # clangd lsp
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
} 
