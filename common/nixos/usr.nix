{
  config,
  stable,
  myvars,
  ...
}:
let
  inherit (myvars) username shell;
in
{
  users = {
    mutableUsers = true;
    defaultUserShell = stable.${shell};
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
