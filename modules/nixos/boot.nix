{ lib, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "nowatchdog"
      "modprobe.blacklist=sp5100_tco" # watchdog for AMD
      "modprobe.blacklist=iTCO_wdt" # watchdog for Intel
    ];
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
    };

    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = lib.mkDefault "auto";
      };
    };
  };
}
