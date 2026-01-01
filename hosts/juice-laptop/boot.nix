{
  pkgs,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  environment.systemPackages = with pkgs; [
    # For debugging and troubleshooting Secure Boot.
    sbctl
  ];
  boot = {
    loader = {
      #conflict with secureboot, so we disable it
      systemd-boot.enable = lib.mkForce true;
    };
    #lanzaboote = {
    #enable = true;
    #pkiBundle = "/var/lib/sbctl";
    #};
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
    ];
    kernelModules = ["kvm-amd"];
    extraModulePackages = [];
  };
}
