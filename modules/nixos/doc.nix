{
  pkgs,
  config,
  lib,
  ...
}:
{
  documentation = {
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  environment.packages = with pkgs; [
    tldr
  ];
}
