{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.curl ];

  home.file.".curlrc".source = ./curl/.curlrc;
}