{ mylib, myvars, ... }:
let
  inherit (mylib) mkImports;
in
{
  imports = mylib.mkImports ./.;
}
