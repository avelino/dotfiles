# nix configuration by Avelino

configuration for macOS and NixOS

# install

```bash
sh <(curl -L https://nixos.org/nix/install)
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# install homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## macOS
```bash
nix build .#darwinConfigurations.default.system
./result/sw/bin/darwin-rebuild switch --flake .#default
```

## NixOS
```bash
nix build .#nixosConfigurations.nixos.system
./result/sw/bin/nixos-rebuild switch --flake .#nixos
```
