{ pkgs, lib, ... }:
let
  commonPackages = with pkgs; [
    # Dev tools
    git
    gh
    act
    hugo

    # Languages and runtimes
    go
    nodejs
    yarn
    clojure
    babashka
    clj-kondo
    clojure-lsp

    # Utilities / CLIs
    d2
    jq
    kubectl
    kubectx
    stern
    argocd

    # Language Servers and Development Tools
    bash-language-server
    clang-tools
    delve
    dockerfile-language-server-nodejs
    gofumpt
    nil
    nixfmt-classic
    pgformatter
    shellcheck
    shfmt
    stylua
    lua-language-server
    tailwindcss-language-server
    taplo
    terraform-ls
    tflint
    tree-sitter
    typescript-language-server
    vscode-langservers-extracted
    yaml-language-server
    yamllint
    zls
  ];

  darwinExtra = with pkgs; [
    # Apps específicos do macOS
    arc-browser
    unnaturalscrollwheels

    # Runtimes específicos/úteis
    graalvm-ce
    rustup
  ];

  linuxExtra = with pkgs; [ ];
in
{
  home.packages = commonPackages
    ++ lib.optionals pkgs.stdenv.isDarwin darwinExtra
    ++ lib.optionals pkgs.stdenv.isLinux linuxExtra;
}



