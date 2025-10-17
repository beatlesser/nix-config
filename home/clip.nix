{ pkgs, ... }:
{
  services.cliphist = {
    enable = true;
    #clipboardPackage = pkgs.wl-clipboard-rs;
  };
  #services.wl-clip-persist.enable = true;
}
