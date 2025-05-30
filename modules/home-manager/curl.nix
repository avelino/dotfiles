{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.curl ];

  home.file.".curlrc".text = ''
    user-agent = "Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0"
    referer = ";auto"
    connect-timeout = 10
    progress-bar
    max-time = 90
    show-error
    ipv4
  '';
}