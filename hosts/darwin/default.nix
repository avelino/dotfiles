{ config, pkgs, username, ... }:

{
  # Import modules
  imports = [
    ../../modules/nix.nix
    ../../modules/darwin/preferences.nix
    ../../modules/darwin/dock.nix
    ../../modules/darwin/system.nix
    ../../modules/darwin/homebrew.nix
  ];

  # Define system state version (required)
  system.stateVersion = 5;

  # Configure home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username; };
    users.${username} = { pkgs, ... }: {
      home = {
        stateVersion = "23.11";
        username = username;
        homeDirectory = "/Users/${username}";

        packages = with pkgs; [
          # Applications
          arc-browser
          unnaturalscrollwheels
        ];
      };

      programs = {
        home-manager.enable = true;
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        # vscode.enable = true; # Enable VSCode configuration
      };

      imports = [
        ../../modules/home-manager/shell.nix
        ../../modules/home-manager/vscode.nix
        ../../modules/home-manager/zed.nix
        ../../modules/home-manager/git.nix
        ../../modules/home-manager/tmux.nix
        ../../modules/home-manager/ssh.nix
        ../../modules/home-manager/rio.nix
        ../../modules/home-manager/logseq.nix
        ../../modules/home-manager/curl.nix
        ../../modules/home-manager/clojure.nix
        ../../modules/home-manager/neovim.nix
        ../../modules/home-manager/dev.nix
        ../../modules/home-manager/aerospace.nix
      ];
    };
  };

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
    # System utilities
    eza
    btop
    htop
    tmux
    bat
    delta
    direnv
    fzf
    ripgrep
    fd
    jq
    yq
    silver-searcher
    cmake
    fish

    # Development tools
    git
    gh
    neovim
    act
    hugo
    graalvm-ce

    # Languages and runtimes
    go
    nodejs
    yarn
    rustup
    clojure
    babashka
    clj-kondo
    clojure-lsp

    # environment
    # yabai
    # skhd

    # Development Tools
    jq
    d2

    # Kubernetes and Cloud
    kubectl
    kubectx
    stern
    argocd

    # Language Servers and Development Tools
    bash-language-server
    clang-tools # clangd lsp
    delve
    dockerfile-language-server-nodejs
    gofumpt
    htmx-lsp
    nil # nix lsp
    nixfmt-classic
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
    maple-mono-NF
    font-awesome
  ];

  # Enable TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  # Configuração do fish para nix-darwin
  programs.fish.enable = true;
  environment.shells = with pkgs; [ bash zsh fish ];
}
