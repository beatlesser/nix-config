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

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

}
