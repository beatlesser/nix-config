{
  pkgs,
  inputs,
  username,
  config,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.impermanence.nixosModules.impermanence
    inputs.nix-index-database.nixosModules.nix-index
    ../../modules/home
    ../../modules/sys
  ];

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  nixpkgs = {
    config.cudaSupport = true;
    hostPlatform = "x86_64-linux";
  };

  wsl = {
    enable = true;
    defaultUser = "${username}";
    useWindowsDriver = true;
  };

  networking.hostName = "wsl";

  programs = {
    ssh.startAgent = true;

    nix-ld = {
      enable = true;
      libraries = config.hardware.graphics.extraPackages;
      package = pkgs.nix-ld-rs;
    };

    dconf.enable = true;
  };

  programs.git.enable = true;

  environment.systemPackages = with pkgs; [
    # System Packages
    curl
    wget
    just

    cliphist # 管理和查看剪贴板历史记录
    wl-clipboard # 命令行工具，操作剪贴板
  ];

  system.stateVersion = "25.05";
}
