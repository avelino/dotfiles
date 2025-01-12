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
    exa
    delta
    gh

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