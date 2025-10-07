{ myLib, ... }:
let
  inherit (myLib) mkImports;
in
{
  imports = myLib.mkImports ./.;

  programs = {
    fish.enable = true;
  };
}
