{ pkgs, lib, ... }:
let
  packages = import ../packages.nix;

  # Map Homebrew package names to Nix equivalents
  nixNames = {
    # Languages
    "borkdude/brew/babashka" = "babashka";
    "clojure/tools/clojure" = "clojure";
    "oven-sh/bun/bun" = "bun";
    "node" = "nodejs";
    # LSP
    "clojure-lsp/brew/clojure-lsp-native" = "clojure-lsp";
    "dockerfile-language-server" = "dockerfile-language-server-nodejs";
    "nixfmt" = "nixfmt-classic";
    # CLI
    "nvim" = "neovim";
    "git-delta" = "delta";
    "fd" = "fd";
  };

  toNixName = name: nixNames.${name} or name;

  # Packages to skip on Linux (Darwin-specific or not in nixpkgs)
  skipOnLinux = [
    "nodenv"
    "nvm"
    "poetry"
    "python@3.13"
    "rustup-init"
    "uv"
    "cocoapods"
    "llvm"
    "cmake"
    "the_silver_searcher"
    "gnupg"
    "imagemagick"
  ];

  isNotSkipped = name: !builtins.elem name skipOnLinux;

  # Build Linux package list from central definition
  linuxBrews = builtins.filter isNotSkipped (
    packages.devops
    ++ packages.languages.brewOnly
    ++ packages.languages.common
    ++ packages.buildTools
    ++ packages.lsp.common
    ++ packages.lsp.brewOnly
    ++ packages.lsp.nixOnly
    ++ packages.cli
    ++ packages.docs
  );

  linuxPackages = map (name: pkgs.${toNixName name}) linuxBrews;

  # Darwin fallback - packages better installed via Nix even on macOS
  darwinFallback = with pkgs; [
    nil
    babashka
    clj-kondo
  ];
in
lib.mkMerge [
  (lib.mkIf pkgs.stdenv.isLinux {
    home.packages = linuxPackages;
  })
  (lib.mkIf pkgs.stdenv.isDarwin {
    home.packages = darwinFallback;
  })
]
