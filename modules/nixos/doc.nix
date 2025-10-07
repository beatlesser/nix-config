{
  pkgs,
  ...
}:
{
  documentation = {
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    tldr
  ];
}
