{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tealdeer
  ];

  services.tldr-update = {
    enable = true;
    package = pkgs.tealdeer;
    period = "weekly";
  };

}
