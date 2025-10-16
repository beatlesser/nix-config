{ lib, pkgs, ... }:
{
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_zen;

    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
    ];

    kernelModules = [ ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "btrfs"
      ];
      kernelModules = [ ];
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = lib.mkDefault "/efi";
      };
      systemd-boot = {
        enable = true;
        consoleMode = lib.mkDefault "auto";
      };
    };

    tmp.cleanOnBoot = true;
  };
}
