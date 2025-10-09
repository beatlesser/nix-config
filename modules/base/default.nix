{ mylib, ... }:
let
  inherit (mylib) mkImports;
in
{
  imports = mkImports ./.;

}
