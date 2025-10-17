# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  ...
}:
{
  boot = {
    loader.efi.efiSysMountPoint = "/efi";

    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
    ];

    kernelModules = [ ];
  };

  programs.hyprland.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  documentation = {
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
