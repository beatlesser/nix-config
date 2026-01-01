# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  exvars,
  ...
}: {
  programs.niri.enable = true;
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.ly = {
      enable = true;
      settings = {
        animation = "colormix";
        vi_mode = true;
      };
    };
  };
  documentation = {
    info.enable = false;
    nixos.enable = false;
  };
  programs = {
    xwayland.enable = true;
    nix-ld.enable = true;
  };
  hardware.cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
