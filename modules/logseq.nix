{pkgs, ...}:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
  system.build.activation-script = pkgs.lib.mkIf pkgs.stdenv.isDarwin {
    text = ''
      # Logseq setup
      echo >&2 "setting up logseq..."

      git clone git@github.com:avelino/notes.git ${home}/notes
      
      # Setup symlink
      $DRY_RUN_CMD rm -rf ${home}/.logseq
      $DRY_RUN_CMD ln -s ${home}/notes/.logseq ${home}/.logseq
    '';
  };

  # Install Logseq
  environment.systemPackages = with pkgs; [
    logseq
  ];
} 