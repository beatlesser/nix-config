{ ... }:
{
  programs = {
    fish.enable = true;
    bash = {
      enable = true;
      enableCompletion = true;
    };
  };
}
