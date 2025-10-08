{ mylib, myVars, ... }:
let
  inherit (mylib) mkImports;
in
{
  imports = mylib.mkImports ./.;
  #disable system doc, we use tlrc instead
  documentation = {
    man.enable = false;
    info.enable = false;
    nixos.enable = false;
  };
}
