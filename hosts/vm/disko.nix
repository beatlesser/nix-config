{ disko, ... }:
{
  imports = [ disko.nixosModules.disko ];

  disko.devices = {
    disk.main = {
      device = "/dev/sda";
      type = "disk";
      content = {
        type = "gpt"; # GPT partitioning scheme
        partitions = {
          # EFI Partition
          esp = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
                "umask=0077"
              ];
            };
          };
          swap = {
            name = "swap";
            size = "5G";
            content = {
              type = "swap";
              discardPolicy = "both";
              resumeDevice = true;
            };
          };
          # Btrfs Root Partition
          root = {
            size = "100%"; # Use remaining space
            content = {
              type = "btrfs";
              subvolumes = {
                "@" = {
                  mountOptions = [ "compress=zstd" ]; # Compression for better performance
                  mountpoint = "/"; # Root subvolume
                };
                "@home" = {
                  mountOptions = [ "compress=zstd" ]; # Compression for persistent data
                  mountpoint = "/home"; # Persistent subvolume
                };
                "@nix" = {
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                    "noacl"
                  ]; # Optimize for Nix store
                  mountpoint = "/nix"; # Nix subvolume
                };
              };
            };
          };
        };
      };
    };
  };
}
