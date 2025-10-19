{ unstable, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with unstable; [

        (fcitx5-rime.override {
          rimeDataPkgs = [
            rime-ice
          ];
        })
        fcitx5-configtool
        fcitx5-gtk
        #kdePackages.fcitx5-qt

        (catppuccin-fcitx5.override {
          withRoundedCorners = true;
        }) # fcitx5-theme

      ];
      settings = {
        addons = {
          classicui.globalSection.Theme = "catppuccin-mocha-blue";
          classicui.globalSection.DarkTheme = "catppuccin-mocha-blue";
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
