{
  pkgs,
  inputs,
  host,
  mylib,
  myvars,
  config,
  ...
}:
let
  inherit (myvars) username;
  inherit (mylib) relativeToRoot;

  base-modules = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  home-modules = map relativeToRoot [
    "modules/home"
  ];

  nixos-modules = map relativeToRoot [
    "modules/nixos/usr.nix"
    "modules/nixos/nix.nix"
    "modules/nixos/pkgs.nix"
    "modules/nixos/timezone.nix"
  ];
in
{
  imports = base-modules ++ home-modules ++ nixos-modules;

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

  environment.systemPackages = with pkgs; [
    # System Packages
    curl
    wget
    just

    cliphist # 管理和查看剪贴板历史记录
    wl-clipboard # 命令行工具，操作剪贴板
  ];

  #disable system doc, we use tldr instead
  documentation = {
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };

  system.stateVersion = "25.05";
}
