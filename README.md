# Nix configuration by Avelino

Nix configuration for *macOS and NixOS*, all laptops have nomenclature ending in `oo` *(igloo, kazoo, zentoo)* to remember the hidden passion for **gentoo**.

# install

```bash
bash <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix && \
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# install homebrew (macOS)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## macOS

* `igloo` is m1 personal laptop
* `kazoo` is m3 business laptop

```bash
darwin-rebuild switch --flake .#avelino-igloo # or .#avelino-kazoo
./result/sw/bin/darwin-rebuild switch --flake .
```

## NixOS (linux)

* `zentoo` is thinkpad x1 laptop

```bash
nix build .#nixosConfigurations.avelino-zentoo.system
./result/sw/bin/nixos-rebuild switch --flake .#avelino-zentoo
```
