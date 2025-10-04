{
  config,
  pkgs,
  username,
  email,
  ...
}:
{
  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.fish;
    users.${username} = {
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
}
