{
  pkgs,
  myvars,
  ...
}:
let
  inherit (myvars) username;
in
{
  nix = {
    package = pkgs.lix;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
    channel.enable = false;
    settings = {
      extra-platforms = [
        "aarch64-linux"
        "arm-linux"
      ];
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      keep-going = true;
      warn-dirty = false;
      http-connections = 16;

      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.garnix.io" # add garnix cache form github loneros-nixos repo
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      allowed-users = [
        "root"
        "${username}"
      ];
      trusted-users = [
        "root"
        "${username}"
      ];
    };
  };
}
