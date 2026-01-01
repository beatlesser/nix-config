{
  pkgs,
  nixpkgs,
  exvars,
  system,
  ...
}: {
  nix = {
    package = pkgs.lix;
    nixPath = ["nixpkgs=${nixpkgs}"];
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      dates = ["weekly"];
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
      http-connections = 20;
      substituters = [
        "https://hyprland.cachix.org"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
        "https://loneros.cachix.org" # thank dalao's bin server
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "loneros.cachix.org-1:dVCECfW25sOY3PBHGBUwmQYrhRRK2+p37fVtycnedDU="
      ];
      allowed-users = [
        "root"
        "${exvars.username}"
      ];
      trusted-users = [
        "root"
        "${exvars.username}"
      ];
    };
  };
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
}
