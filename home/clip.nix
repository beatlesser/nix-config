{ unstable, ... }:
{
  services.cliphist = {
    enable = true;
    #clipboardPackage = unstable.wl-clipboard-rs;
  };
  #services.wl-clip-persist.enable = true;
}
