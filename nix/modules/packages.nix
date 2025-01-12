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
    
    # Nix tools
    nix
    nix-prefetch
    nix-prefetch-git
    nix-index
    
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