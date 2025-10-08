{ myvars, mylib, ... }:
let
  inherit (myvars) username;
  inherit (mylib) relativeToRoot;
in
{
  imports = map relativeToRoot [
    "modules/home"
  ];

  home-manager.users.${username} = {

    programs.home-manager.enable = true;

    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "25.05";
    };

  };
}
