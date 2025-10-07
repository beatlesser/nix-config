{ lib, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];

    kernelModules = [ "kvm" ];

    initrd = {
      availableKernelModule = [
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
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        consoleMode = lib.mkDefault "auto";
      };
    };

    tmp.cleanOnBoot = true;

    supportedFilesystems = [
      "ext4"
      "btrfs"
      "xfs"
      "ntfs"
      "fat"
      "vfat"
      "exfat"
    ];
  };
}
