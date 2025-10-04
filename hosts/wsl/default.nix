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
    fish.enable = true;

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
      duf # 查看系统磁盘的空间使用情况 better df
      lsd # better ls
      killall # better kill
      openssl # SSL/TLS 安全通信、证书管理和加密。
      jq # 处理 JSON 数据
      unzip
      fzf
      bat # better cat
      fd # better find
      duf # better du
      ripgrep # better grep
      file
      dos2unix
      just
      gcc
      git

      cliphist # 管理和查看剪贴板历史记录
      wl-clipboard # 命令行工具，操作剪贴板

      fastfetch
      btop
   ];

  system.stateVersion = "25.05";
}
