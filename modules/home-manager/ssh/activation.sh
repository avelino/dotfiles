echo "Setting up SSH configuration..."
install -d -m 700 ~/.ssh

# Setup certificate files
touch ~/.ssh/bast-cert00.pub ~/.ssh/bast-cert01.pub
chmod 600 ~/.ssh/bast-cert00.pub ~/.ssh/bast-cert01.pub


