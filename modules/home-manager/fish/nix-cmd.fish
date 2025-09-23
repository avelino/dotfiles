if test (count $argv) -eq 0
  echo "Usage: nix-cmd [upgrade|update|search|install|rebuild|clear] [PACKAGE]"
  return 1
end

set -l action $argv[1]
set -l repo @REPO_DIR@
set -l host (hostname -s)
if test -z "$host"
  if scutil --get LocalHostName 2>/dev/null >/dev/null
    set host (scutil --get LocalHostName)
  end
end

set -l rebuild_cmd
set -l system_attr
if type -q darwin-rebuild
  set rebuild_cmd "darwin-rebuild switch --flake $repo#$host --profile-name $host"
  set system_attr "darwinConfigurations.$host.system"
else if type -q nixos-rebuild
  set rebuild_cmd "sudo nixos-rebuild switch --flake $repo#$host --profile-name $host"
  set system_attr "nixosConfigurations.$host.config.system.build.toplevel"
end

switch $argv[1]
  case upgrade
    nix-cmd update
    echo "Rebuilding system profile..."
    echo "Cleaning old generations..."
    nix-collect-garbage -d
    if test -n "$rebuild_cmd"
      eval $rebuild_cmd; or true
      if test -n "$system_attr"; and nix eval $repo#$system_attr >/dev/null 2>/dev/null
        set -l suspects \
          nixpkgs#cudaPackages.cudaFlags \
          nixpkgs#cudaPackages.cudaVersion \
          nixpkgs#cudaPackages.cudatoolkit-legacy-runfile \
          nixpkgs#f3d_egl \
          nixpkgs#darwin.iproute2mac \
          nixpkgs#windows.mingw_w64_pthreads
        for suspect in $suspects
          if nix eval $suspect >/dev/null 2>/dev/null
            echo "Inspecting dependency on $suspect"
            nix why-depends $repo#$system_attr $suspect 2>/dev/null; or true
          end
        end
      end
    else
      echo "Note: system rebuild tool not found (darwin-rebuild/nixos-rebuild)."
    end
    echo "Upgrading Homebrew packages..."
    if type -q brew
      brew upgrade
    else
      echo "Homebrew not found; skipping upgrade"
    end
  case update
    echo "Updating flake inputs..."
    if test -d $repo
      if pushd $repo >/dev/null
        if not nix flake update --commit-lock-file
          echo "nix flake update --commit-lock-file failed; retrying without auto-commit"
          nix flake update
        end
        popd >/dev/null
      end
    end
    echo "Updating Homebrew..."
    if type -q brew
      brew update
    else
      echo "Homebrew not found; skipping update"
    end
  case search
    if test (count $argv) -lt 2
      echo "Usage: nix-cmd search PACKAGE-NAME"
      return 1
    end
    echo "Searching in Nix packages..."
    nix search nixpkgs $argv[2]
    echo "Searching in Homebrew packages..."
    brew search $argv[2]
  case install
    if test (count $argv) -lt 2
      echo "Usage: nix-cmd install PACKAGE-NAME"
      return 1
    end
    echo "Attempting to install via Nix..."
    nix profile install nixpkgs#$argv[2]
  case rebuild
    if test -n "$rebuild_cmd"
      eval $rebuild_cmd
    else
      echo "System rebuild tool not found."
    end
  case clear
    echo "Attempting to clear via Nix..."
    nix-collect-garbage -d
    nix store optimise
  case '*'
    echo "Usage: nix-cmd [upgrade|update|search|install|rebuild|clear] [PACKAGE]"
    echo "  upgrade: Update inputs, rebuild system, upgrade Homebrew"
    echo "  update: Update inputs only"
    echo "  search PACKAGE: Search in Nix and Homebrew"
    echo "  install PACKAGE: Install via nix profile"
    echo "  rebuild: Re-run system switch"
    echo "  clear: Collect garbage and optimise store"
end


