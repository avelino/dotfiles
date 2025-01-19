# nix configuration by Avelino

configuration for macOS and NixOS

# install

```bash
bash <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix && \
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# install homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## macOS

```bash
nix build .#darwinConfigurations.$(hostname -s).system --extra-experimental-features "nix-command flakes" && \
    ./result/sw/bin/darwin-rebuild switch --flake .
```

## NixOS

```bash
nix build .#nixosConfigurations.nixos.system && \
    ./result/sw/bin/nixos-rebuild switch --flake .#nixos
```
