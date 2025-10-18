{ unstable, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with unstable; [
        # for flypy chinese input method
        (fcitx5-rime.override {
          rimeDataPkgs = [
            rime-ice
            rime-moegirl
            rime-wanxiang
          ];
        })

        # needed enable rime using configtool after installed
        fcitx5-configtool

        # fcitx5-chinese-addons # we use rime instead
        fcitx5-gtk # gtk im module

        (catppuccin-fcitx5.override {
           withRoundedCorners = true;
	}) # fcitx5-theme
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
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "rime";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "rime";
        };
      };
    };
  };
}
