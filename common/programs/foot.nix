{...}: {
  programs.foot = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    theme = "catppuccin-mocha";
    settings = {
      main = {
        font = "MapleMono NF CN:size=14";
      };
      cursor = {
        style = "beam";
      };
      key-bindings = {
        cliboard-copy = "Control+c XF86Copy";
        cliboard-paste = "Control+v XF86Paste";
      };
    };
  };
}
