{lib, ...}: {
  boot = {
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
      kernelModules = [];
    };
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = lib.mkDefault true;
        editor = false;
        configurationLimit = lib.mkDefault 3;
      };
    };
    tmp.cleanOnBoot = true;
  };
}
