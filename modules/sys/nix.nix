{
  pkgs,
  username,
  ...
}:
{
  nix = {
    # @TODO enable when lix is patched
    # package = pkgs.lix;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    optimise = {
      automatic = false;
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
      http-connections = 50;

      substituters = [
        "https://cache.garnix.io" # add garnix cache form github loneros-nixos repo
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [ "https://nix-on-droid.cachix.org" ];
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

  programs.nh = {
    enable = true;
    clean.enable = true;
    flake = "/home/${username}/nix-config";
  };
}
