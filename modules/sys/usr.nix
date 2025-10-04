{
  config,
  pkgs,
  username,
  email,
  ...
}: {
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.fish;
    users.${username} = {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };
}
