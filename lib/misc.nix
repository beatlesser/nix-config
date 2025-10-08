{ lib, ... }:
let
  inherit (builtins)
    map
    attrNames
    mapAttrs
    readDir
    ;
  inherit (lib) filterAttrs strings path;
in
{
  #helper func
  relativeToRoot = path.append ../.;

  mkImports =
    dir:
    map (path: dir + "/${path}") (
      attrNames (
        filterAttrs (
          name: _type: (_type == "directory" || (name != "default.nix" && strings.hasSuffix ".nix" name))
        ) (readDir dir)
      )
    );

}
