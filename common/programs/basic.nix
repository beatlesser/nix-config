{
  pkgs,
  system,
  lib,
  ...
}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.allowBroken = true;
    hostPlatform = "${system}";
  };
  programs = {
    nano.enable = false;
    firefox.enable = true;
  };
  environment.systemPackages = with pkgs; [
    gcc
    just
    cliphist
    wl-clipboard-rs
  ];
}
