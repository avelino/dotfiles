# dotfiles

personal files

## Install

### Traditional Method
```shell
git clone https://github.com/avelino/dotfiles.git ~/dotfiles && \
	cd ~/dotfiles && \
	sh install.sh
```

### Using Nix (Recommended)

1. Install Nix:
```shell
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

2. Enable Flakes:
```shell
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

3. Backup existing configs:
```shell
# Create backup directory
mkdir -p ~/.config/backup

# Backup existing configs
mv ~/.config/fish/config.fish ~/.config/backup/
mv ~/.bashrc ~/.config/backup/
mv ~/.zshenv ~/.config/backup/
mv ~/.profile ~/.config/backup/
mv ~/.bash_profile ~/.config/backup/
```

4. Clone and Apply Configuration:
```shell
git clone https://github.com/avelino/dotfiles.git ~/dotfiles
nix run home-manager -- switch --flake ~/dotfiles/nix
```

## Nix Configuration

### Directory Structure
```
nix/
├── flake.nix          # Flake configuration
├── home.nix           # Main home-manager config
└── modules/           # Configuration modules
    ├── editors.nix    # Neovim and editor configs
    ├── git.nix        # Git configuration
    ├── packages.nix   # System packages
    ├── shell.nix      # Shell configurations
    └── terminal.nix   # Terminal configs (tmux)
```

### Common Tasks

#### Update Configuration
```shell
# Update and apply changes
nix flake update ~/dotfiles/nix
nix run home-manager -- switch --flake ~/dotfiles/nix
```

#### Add New Package
1. Edit `nix/modules/packages.nix`
2. Add package to `home.packages`
3. Apply changes:
```shell
nix run home-manager -- switch --flake ./nix
```

#### Add Shell Alias
1. Edit `nix/modules/shell.nix`
2. Add to `shellAliases`
3. Apply changes:
```shell
nix run home-manager -- switch --flake ./nix
```

### Troubleshooting

If you encounter issues:
```shell
# Show detailed error trace
nix run home-manager -- switch --flake ~/dotfiles/nix --show-trace

# Clean old generations
nix-collect-garbage -d
```
