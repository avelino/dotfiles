{ config, pkgs, lib, ... }:

{
  home.packages =
    lib.optionals pkgs.stdenv.isLinux [
      pkgs.curl
    ];

  home.file.".curlrc".source = ./curl/.curlrc;
}