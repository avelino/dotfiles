{ pkgs, lib, ... }: {
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Import modules
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/editors.nix
    ./modules/terminal.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # CLI packages
  home.packages = with pkgs; [
    # CLI Tools & Utilities
    ripgrep
    fd
    jq
    fzf
    tree
    htop
    bat
    eza
    delta
    gh
    coreutils
    wget
    curl
    parallel
    watch
    p7zip
    less
    gawk
    inetutils
    mosh

    # Development Tools
    git
    lazygit
    direnv
    cmake
    gcc
    ctop
    docker-buildx
    act
    hub

    # Languages & Runtime
    go
    gopls
    rustup
    nodejs_latest
    yarn
    elixir
    nim
    sbcl
    clojure
    leiningen
    babashka
    d2
    
    # Language Servers & Linters
    marksman
    yaml-language-server
    nodePackages.eslint
    nodePackages.prettier
    taplo

    # Cloud & Infrastructure
    awscli2
    docker
    docker-compose
    kubectl
    kubectx
    helmfile
    kompose

    # Text Editors & IDEs
    helix
    micro

    # Media Tools
    ffmpeg
    imagemagick
    yt-dlp

    # Database Tools
    mysql-client
    redis

    # Security Tools
    pinentry_mac
    gnupg

    # Nix Tools
    nix
    nix-prefetch-git
    nix-index
    nixfmt-classic

    # Version Control
    mercurial
    subversion

    # Build Tools
    autoconf
    automake
    cmake

    fzf
    htop
    jq
    hugo
    imagemagick
    ffmpeg
    yt-dlp
    xclip
    yarn
    logseq
  ];
} 