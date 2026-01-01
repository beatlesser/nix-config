{pkgs, ...}: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings
      '';
      shellAliases = {
        cls = "clear";
        ls = "lsd";
        la = "lsd -ha";
        ll = "lsd -hla";
        zz = "z -";
      };
    };
    bat.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    television = {
      enable = true;
      #enableFishIntegration = true;
    };
  };
  environment.systemPackages = with pkgs; [
    fastfetch
    tealdeer
    btop
    fd
    ripgrep
    lsd
  ];
}
