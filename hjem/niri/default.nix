{
  pkgs,
  lib,
  noctalia,
  ...
}: {
  packages = [noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default];
  rum.desktops.niri = {
    enable = true;
    config = lib.concatMapStringsSep "\n" builtins.readFile [
      ./config.kdl
      ./binds.kdl
      ./window-rules.kdl
      ./spawn-at-startup.kdl
      ./environment.kdl
    ];
  };
}
