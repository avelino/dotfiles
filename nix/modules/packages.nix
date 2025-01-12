{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Development tools
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
    nixfmt

    # Languages and tools
    go
    rustup
    nodejs
    yarn
    python3
    python3Packages.pip
    python3Packages.ipython

    # Cloud tools
    awscli2
    docker
    docker-compose
  ];
} 