{ pkgs, ... }:
{
  xdg.dataFile."fcitx5/rime/default.custom.yaml" = {
    enable = true;
    source = ./default.custom.yaml;
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        #fcitx5-gtk # Fcitx5 gtk im module and glib based dbus client library
        #kdePackages.fcitx5-qt
        (catppuccin-fcitx5.override {
          withRoundedCorners = true;
        })
        (fcitx5-rime.override {
          rimeDataPkgs = [
            rime-ice
            rime-wanxiang
          ];
        })
      ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "catppuccin-mocha-blue";
          classicui.globalSection.DarkTheme = "catppuccin-mocha-blue";
          pingyin.globalSection = {
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
            DefaultIM = "rime";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "rime";
          GroupOrder."0" = "Default";
        };
      };
    };
  };
}
