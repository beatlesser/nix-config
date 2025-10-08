{ mylib, myVars, ... }:
let
  inherit (mylib) mkImports;
in
{
  imports = mylib.mkImports ./.;
}
