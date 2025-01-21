{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.logseq ];

  home.activation = {
    logseqSetup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      echo >&2 "setting up logseq..."
      mkdir -p "$HOME/logseq-avelino"

      if [ ! -d "$HOME/notes" ]; then
        git clone git@github.com:avelino/notes.git "$HOME/notes"
      fi

      # Setup symlink
      rm -rf "$HOME/.logseq"
      ln -s "$HOME/notes/.logseq" "$HOME/.logseq"
    '';
  };
}
