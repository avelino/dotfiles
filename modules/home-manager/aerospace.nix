{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (pkgs.stdenv.isDarwin) {
    home.file.".aerospace.toml".source = ./aerospace/aerospace.toml;
  };
}
