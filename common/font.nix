{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = with pkgs; [
      # icon fonts
      material-design-icons
      font-awesome
      #nerd font
      nerd-fonts.symbols-only # symbols icon only
      nerd-fonts.jetbrains-mono
      noto-fonts # 大部分文字的常见样式，不包含汉字
      noto-fonts-color-emoji # 彩色的表情符号字体
      # Adobe 以 Source Han Sans/Serif 的名称发布此系列字体
      source-sans # 无衬线字体，不含汉字。字族名叫 Source Sans 3，以及带字重的变体（VF）
      source-serif # 衬线字体，不含汉字。字族名叫 Source Serif 4，以及带字重的变体
      source-han-sans # 思源黑体
      source-han-serif # 思源宋体
      source-han-mono # 思源等宽
      # 霞鹜文楷 屏幕阅读版
      # https://github.com/lxgw/LxgwWenKai-Screen
      lxgw-wenkai-screen
      # Maple Mono NF CN (连字 未微调版，适用于高分辨率屏幕)
      # Full version, embed with nerdfonts icons, Chinese and Japanese glyphs
      # https://github.com/subframe7536/maple-font
      maple-mono.NF-CN-unhinted
    ];
    fontconfig = {
      # User defined default fonts
      # https://catcat.cc/post/2021-03-07/
      defaultFonts = {
        serif = [
          # 西文: 衬线字体（笔画末端有修饰(衬线)的字体，通常用于印刷。）
          "Source Sans 3"
          # 中文: 宋体（港台称明體）
          "Source Han Serif SC" # 思源宋体
          "Source Han Serif TC"
        ];
        # SansSerif 也简写做 Sans, Sans 在法语中就是「without」或者「无」的意思
        sansSerif = [
          # 西文: 无衬线字体（指笔画末端没有修饰(衬线)的字体，通常用于屏幕显示）
          "Source Serif 4"
          # 中文: 黑体
          "LXGW WenKai Screen" # 霞鹜文楷 屏幕阅读版
          "Source Han Sans SC" # 思源黑体
          "Source Han Sans TC"
        ];
        # 等宽字体
        monospace = [
          # 中文
          "Maple Mono NF CN" # 中英文宽度完美 2:1 的字体
          "Source Han Mono SC" # 思源等宽
          "Source Han Mono TC"
          # 西文
          "JetBrainsMono Nerd Font"
        ];
        emoji = ["Noto Color Emoji"];
      };
      antialias = true; # 抗锯齿
      hinting.enable = false; # 禁止字体微调 - 高分辨率下没这必要
      subpixel = {
        rgba = "rgb"; # IPS 屏幕使用 rgb 排列
      };
    };
  };
  # https://wiki.archlinux.org/title/KMSCON
  services.kmscon = {
    # Use kmscon as the virtual console instead of gettys.
    # kmscon is a kms/dri-based userspace virtual terminal implementation.
    # It supports a richer feature set than the standard linux console VT,
    # including full unicode support, and when the video card supports drm should be much faster.
    enable = true;
    fonts = with pkgs; [
      {
        name = "Maple Mono NF CN";
        package = maple-mono.NF-CN-unhinted;
      }
      {
        name = "JetBrainsMono Nerd Font";
        package = nerd-fonts.jetbrains-mono;
      }
    ];
    extraOptions = "--term xterm-256color";
    extraConfig = "font-size=14";
    # Whether to use 3D hardware acceleration to render the console.
    hwRender = true;
  };
}
