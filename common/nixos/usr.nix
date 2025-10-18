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
      #hashedPasswordFile = config.sops.secrets."cyer/pwd".path;
      isNormalUser = true;
      extraGroups = [
        "video"
        "networkmanager"
        "wheel"
      ];
    };
  };
}
