{pkgs, ...}:

let
  home = if pkgs.stdenv.isDarwin then "/Users/avelino" else "/home/avelino";
in
{
  system.activationScripts.postActivation.text = ''
    # Logseq setup
    echo "Setting up Logseq..."
    
    # Create notes directory and clone repository if needed
    mkdir -p ${home}/notes
    if [ ! -d "${home}/notes/logseq" ]; then
      git clone git@github.com:avelino/notes.git ${home}/notes/logseq
    fi
    
    # Create symlink
    rm -f ${home}/.logseq
    ln -s ${home}/notes/logseq ${home}/.logseq
    
    # Set permissions
    chown -R avelino:staff ${home}/notes/logseq
    chmod -R 755 ${home}/notes/logseq
  '';

  # Install Logseq
  environment.systemPackages = with pkgs; [
    logseq
  ];
} 