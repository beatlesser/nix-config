{ pkgs, myvars, ... }:
let
  inherit (myvars) username email;
in
{
  programs = {

    fish = {
      enable = true;
    };

    git = {
      enable = true;
      userName = "${username}";
      userEmail = "${email}";
    };

    fastfetch.enable = true;

    ripgrep.enable = true;

    fd.enable = true;

    bat.enable = true;

    lsd.enable = true;

    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    television = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };
  };
  #if programs do not support,add pkgs manual
  home.packages = with pkgs; [
    duf
  ];
}
