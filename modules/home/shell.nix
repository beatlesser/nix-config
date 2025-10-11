{ pkgs, myvars, ... }:
let
  inherit (myvars) username email;
in
{
  programs = {

    #shell
    fish = {
      enable = true;
      interactiveShellInit = "set fish_greeting";
    };

    #documentation
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = false;
          auto_update_interval_hours = 720;
        };
      };
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
