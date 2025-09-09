{ pkgs, username, ... }:

{
  # Imports de sistema
  imports = [
    ../../modules/nix.nix
  ];

  # DNS configuration for NixOS
  networking = {
    nameservers = [
      "9.9.9.9"    # Quad9 DNS
      "1.1.1.1"    # Cloudflare DNS
      "8.8.8.8"    # Google DNS
    ];
    networkmanager = {
      enable = true;
      dns = "none";  # Disable NetworkManager DNS management
    };
  };

  # Fish shell configuration
  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  # Home Manager (unificado com Darwin)
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit username; };
    users.${username} = { pkgs, ... }: {
      home = {
        stateVersion = "23.11";
        username = username;
        homeDirectory = "/home/${username}";
        packages = with pkgs; [
          git
          gh
          neovim
          act
          hugo

          go
          nodejs
          yarn
          clojure
          babashka
          clj-kondo
          clojure-lsp

          d2
          jq
          kubectl
          kubectx
          stern
          argocd

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
        ];
      };

      imports = [
        ../../modules/home-manager/default.nix
      ];
    };
  };

  # System state version
  system.stateVersion = "23.11";
}