{
  config,
  pkgs,
  myVars,
  ...
}:
let
  inherit (myVars) username shell;
in
{
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.${shell};
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
