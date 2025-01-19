{ pkgs, ... }:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
  # SSH Configuration
  programs.ssh = {
    enable = true;

    # Include external configurations
    includes = [
      "${home}/.orbstack/ssh/config"
      "${home}/.colima/ssh_config"
      "gitpod/config"
    ];

    # Global SSH settings
    extraConfig = ''
      PasswordAuthentication no
      ChallengeResponseAuthentication no
      HashKnownHosts yes
      VisualHostKey yes
      Forwardagent yes
      KexAlgorithms curve25519-sha256,ecdh-sha2-nistp521

      Host *
        IdentityAgent "${home}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';

    # Host-specific configurations
    matchBlocks = {
      "ws.avelino" = {
        hostname = "138.197.3.1";
        port = 22;
        user = "root";
      };

      "clj.social" = {
        hostname = "159.223.195.78";
        port = 22;
        user = "root";
      };

      "guiame" = {
        hostname = "209.126.124.77";
        port = 22;
        user = "root";
      };

      "buser.chat" = {
        hostname = "3.135.3.134";
        port = 22;
        user = "ubuntu";
      };

      "buser.gitlab" = {
        hostname = "gitlab.buser.com.br";
        port = 22;
        user = "ubuntu";
      };

      "moclojer.p001" = {
        hostname = "162.243.162.62";
        port = 22;
        user = "root";
      };

      # Pritunl Zero configurations
      "172.22.*.*" = {
        proxyJump = "bastion@bastohio.buser.com.br:9800";
      };

      "172.28.*.*" = {
        proxyJump = "bastion@bastohio.buser.com.br:9800";
      };

      "172.43.*.*" = {
        proxyJump = "bastion@bastohio.buser.com.br:9800";
      };

      "bastohio.buser.com.br" = {
        extraOptions = {
          "StrictHostKeyChecking" = "yes";
        };
      };

      "172.31.*.*" = {
        proxyJump = "bastion@bastsp.buser.com.br:9800";
      };

      "172.90.*.*" = {
        proxyJump = "bastion@bastsp.buser.com.br:9800";
      };

      "bastsp.buser.com.br" = {
        extraOptions = {
          "StrictHostKeyChecking" = "yes";
        };
      };
    };
  };

  # Ensure SSH directory exists with correct permissions
  home.activation = {
    sshSetup = {
      after = [ "writeBoundary" ];
      before = [ ];
      data = ''
        echo "Setting up SSH configuration..."
        install -d -m 700 ~/.ssh

        # Setup certificate files
        touch ~/.ssh/bast-cert00.pub ~/.ssh/bast-cert01.pub
        chmod 600 ~/.ssh/bast-cert00.pub ~/.ssh/bast-cert01.pub
      '';
    };
  };
}
