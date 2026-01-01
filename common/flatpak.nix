{lib, ...}: {
  services.flatpak = {
    enable = true;
    remotes = lib.mkOptionDefault [
      {
        name = "flathub";
        location = "https://mirrors.ustc.edu.cn/flathub";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
      {
        name = "flathub-official";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
    uninstallUnmanaged = false;
    uninstallUnused = true;
    restartOnFailure = {
      enable = true;
      restartDelay = "60s";
      exponentialBackoff = {
        enable = false;
        steps = 10;
        maxDelay = "1h";
      };
    };
    packages = [
      # { appId = "com.brave.Browser"; origin = "flathub"; }
      "com.qq.QQmusic"
      "com.tencent.WeChat"
      "com.qq.QQ"
    ];
  };
}
