inputs:
let
  unstableOverlay = final: prev: {
    pkgsUnstable = import inputs."nixpkgs-unstable" {
      system = final.system;
      config = {
        allowUnfree = true;
        allowBroken = false;
      };
    };
  };
in {
  inherit unstableOverlay;
  default = unstableOverlay;
}
