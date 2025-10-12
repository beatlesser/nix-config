{
  inputs,
  host,
  myvars,
  pkgs,
  config,
  ...
}:
let
  inherit (myvars) username;
  inherit (inputs) nixos-wsl;
in
{
  imports = [ nixos-wsl.nixosModules.wsl ];

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
