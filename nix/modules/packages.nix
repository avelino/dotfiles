{ pkgs, ... }: {
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
    tmux
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
    python311
    python311Packages.pip
    python311Packages.ipython
    elixir
    nim
    sbcl
    clojure
    leiningen
    babashka
    
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
  ];
} 