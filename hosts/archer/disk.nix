{ disko, ... }:
{

  imports = [ disko.nixosModules.disko ];

  disko.devices.disk.main = {
    device = "/dev/nvme0n1";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          type = "EF00";
          size = "512M";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/efi";
            mountOptions = [
              "fmask=0022"
              "dmask=0022"
            ];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "btrfs";
            subvolumes = {
              "@" = {
                mountpoint = "/";
                mountOptions = [
                  "subvol=@"
                  "compress=zstd"
                ];
              };
              "@home" = {
                mountpoint = "/home";
                mountOptions = [
                  "subvol=@home"
                  "compress=zstd"
                ];
              };
              "@nix" = {
                mountpoint = "/nix";
                mountOptions = [
                  "subvol=@nix"
                  "compress=zstd"
                  "noatime"
                ];
              };
              "@swap" = {
                mountpoint = "/swap";
                mountOptions = [
                  "subvol=@swap"
                  "compress=zstd"
                ];
                swap = {
                  swapfile.size = "4G";
                };
              };
            };
          };
        };
      };
    };
  };
}
