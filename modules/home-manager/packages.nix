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

  darwinExtra = with pkgs; [
    arc-browser
    unnaturalscrollwheels
    graalvm-ce
    rustup
  ];

  linuxExtra = with pkgs; [ ];
in
{
  home.packages = devTools
    ++ languagesAndRuntimes
    ++ cliUtilities
    ++ languageServers
    ++ formattersAndLinters
    ++ lib.optionals pkgs.stdenv.isDarwin darwinExtra
    ++ lib.optionals pkgs.stdenv.isLinux linuxExtra;
}





