{ config, pkgs, lib, ... }: {
  # Ensure programs are using ~/.config rather than
  # /Users/<username>/Library/whatever
  xdg.enable = true;

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Ensure ~/.logseq directory exists
  home.file.".logseq/.keep".text = "";
  # Symbolic links
  home.file = {
    ".logseq/config".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/notes/logseq";
  };

  # Import modules
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/editors.nix
    ./modules/terminal.nix
  ];

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

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
    ncurses

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

    # GUI Apps
    logseq
  ];
} 