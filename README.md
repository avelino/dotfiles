# nix configuration by Avelino

configuration for macOS and NixOS

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
