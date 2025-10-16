{ pkgs, ... }:
{
  #add some cross-host pkgs and programs here
  programs.fish.enable = true;

  programs.firefox = true;

  environment.systemPackages = with pkgs; [
  	cliphist
	wl-clipboard
  ];
}
