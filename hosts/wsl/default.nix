{
  pkgs,
  inputs,
  host,
  myVars,
  config,
  ...
}:
let
  inherit (myVars) username;
in
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ../../modules/home
    ../../modules/nixos/doc.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/usr.nix
    ../../modules/nixos/timezone.nix
  ];

  nixpkgs = {
    config.cudaSupport = true;
    hostPlatform = "x86_64-linux";
  };

  wsl = {
    enable = true;
    defaultUser = "${username}";
    useWindowsDriver = true;
  };

  networking.hostName = "${host}";

  programs = {
    ssh.startAgent = true;

    nix-ld = {
      enable = true;
      libraries = config.hardware.graphics.extraPackages;
      package = pkgs.nix-ld-rs;
    };

    dconf.enable = true;
  };

  programs = {
    git.enable = true;
    fish.enable = true;
  };

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
