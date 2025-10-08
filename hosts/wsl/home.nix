{ myvars, mylib, ... }:
let
  inherit (myvars) username;
in
{
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "25.05";
  };

}
