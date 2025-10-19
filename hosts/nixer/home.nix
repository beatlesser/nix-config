{
  myvars,
  mylib,
  config,
  ...
}:
let
  inherit (myvars) username;
in
{
  programs.home-manager.enable = true;
  programs.nix-index-database.comma.enable = true;

  userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
    };
  };

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

}
