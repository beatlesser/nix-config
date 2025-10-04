{
  config,
  pkgs,
  shell,
  username,
  email,
  ...
}:
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
