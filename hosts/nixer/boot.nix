{
  pkgs,
  lib,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];

  boot = {

    plymouth = { 
    enable = true; 
    theme = "breeze";
    };

    loader = {
      efi.efiSysMountPoint = "/efi";
      #conflict with secureboot, so we disable it
      systemd-boot.enable = lib.mkForce false;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
    ];

    kernelModules = [ "kvm-amd" ];

    extraModulePackages = [ ];
  };
}
