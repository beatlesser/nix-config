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
    duf
    lsd
    unzip
    fzf
    nix-search-tv
    bat # better cat
    fd # better find
    ripgrep # better grep
    file
    dos2unix
    just
    git

    cliphist # 管理和查看剪贴板历史记录
    wl-clipboard # 命令行工具，操作剪贴板

    fastfetch
    btop
  ];

  system.stateVersion = "25.05";
}
