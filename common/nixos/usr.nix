{
  config,
  pkgs,
  myvars,
  ...
}:
let
  inherit (myvars) username shell;
in
{
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.${shell};
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "video"
        "networkmanager"
        "wheel"
      ];
    };
  };
}
