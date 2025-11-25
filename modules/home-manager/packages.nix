{ pkgs, lib, ... }:
let
  devTools = with pkgs; [
    git
    gh
    act
    hugo
  ];

  languagesAndRuntimes = with pkgs; [
    go
    nodejs
    yarn
    clojure
    babashka
    clj-kondo
    clojure-lsp
  ];

  cliUtilities = with pkgs; [
    d2
    jq
    kubectl
    kubectx
    stern
    argocd
  ];

  languageServers = with pkgs; [
    bash-language-server
    clang-tools
    delve
    dockerfile-language-server-nodejs
    gofumpt
    nil
    lua-language-server
    tailwindcss-language-server
    taplo
    terraform-ls
    tflint
    tree-sitter
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
    zls
  ];

  formattersAndLinters = with pkgs; [
    nixfmt-classic
    pgformatter
    shellcheck
    shfmt
    stylua
    yamllint
  ];

  linuxExtra = with pkgs; [ ];

  darwinFallback = with pkgs; [
    # Keep these available on macOS until there is a maintained Homebrew tap.
    nil
    babashka
    clj-kondo
  ];
in
lib.mkMerge [
  (lib.mkIf pkgs.stdenv.isLinux {
    home.packages = devTools
      ++ languagesAndRuntimes
      ++ cliUtilities
      ++ languageServers
      ++ formattersAndLinters
      ++ linuxExtra;
  })
  (lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = darwinFallback;
  })
]





