{ pkgs, ... }:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
  # Install curl
  environment.systemPackages = [ pkgs.curl ];

  # Create curl configuration file
  environment.etc."curlrc".text = ''
    user-agent = "Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101 Firefox/45.0"
    referer = ";auto"
    connect-timeout = 10
    progress-bar
    max-time = 90
    show-error
    ipv4
  '';

  # Link curl configuration
  system.activationScripts.curlSetup = {
    text = ''
      echo "Setting up curl configuration..."
      mkdir -p ${home}
      rm -f ${home}/.curlrc
      ln -sf /etc/curlrc ${home}/.curlrc
      chown avelino:staff ${home}/.curlrc
    '';
    deps = [];
  };
} 