{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    clojure
    babashka
    clj-kondo
    clojure-lsp
  ];

  home.file.".clojure/deps.edn".source = ./clojure/deps.edn;
}