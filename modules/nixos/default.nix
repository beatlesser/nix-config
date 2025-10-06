{ myLib, ... }:
let
  inherit (myLib) mkImports;
in
{
  imports = myLib.mkImports ./.;

  programs = {
    zsh.enable = true;
  };
}
