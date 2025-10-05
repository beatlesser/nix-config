{ pkgs, ... }:
{
  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };

    fastfetch.enable = true;

    ripgrep.enable = true;

    fd.enable = true;

    bat.enable = true;

    lsd.enable = true;

    btop.enable = true;

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    television = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
