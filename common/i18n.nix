{
  host,
  exvars,
  exlib,
  pkgs,
  lib,
  ...
}: let
  inherit
    (exvars)
    username
    timeZone
    defaultLocale
    extraLocale
    ;
  inherit
    (exlib)
    mapToConfig
    ;
in {
  time = {
    timeZone = "${timeZone}";
    hardwareClockInLocalTime = true;
  };
  i18n = {
    defaultLocale = "${defaultLocale}";
    extraLocaleSettings = {
      LC_ADDRESS = "${extraLocale}";
      LC_IDENTIFICATION = "${extraLocale}";
      LC_MEASUREMENT = "${extraLocale}";
      LC_MONETARY = "${extraLocale}";
      LC_NAME = "${extraLocale}";
      LC_NUMERIC = "${extraLocale}";
      LC_PAPER = "${extraLocale}";
      LC_TELEPHONE = "${extraLocale}";
      LC_TIME = "${extraLocale}";
    };
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        waylandFrontend = true;
        addons = with pkgs; [
          (catppuccin-fcitx5.override {
            withRoundedCorners = true;
          })
          (fcitx5-rime.override {
            rimeDataPkgs = [
              rime-ice
            ];
          })
        ];
        settings = {
          addons = {
            classicui.globalSection.Theme = "catppuccin-mocha-blue";
            classicui.globalSection.DarkTheme = "catppuccin-mocha-blue";
            pinyin.globalSection = {
              PageSize = 9;
              CloudPinyinEnabled = "True";
              CloudPinyinIndex = 2;
            };
            cloudpinyin.globalSection = {
              Backend = "Baidu";
            };
          };
          inputMethod = {
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us";
              DefaultIM = "keyboard-us";
            };
            "Groups/0/Items/0".Name = "keyboard-us";
            "Groups/0/Items/1".Name = "Rime";
            GroupOrder."0" = "Default";
          };
        };
      };
    };
  };
}
