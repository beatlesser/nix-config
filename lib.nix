{ lib, ... }:
{
  inherit (builtins) map attrNames readDir;
  mkImports =
    dir:
    map (path: dir + "/${path}") (
      attrNames (
        lib.filterAttrs (
          name: _type: (_type == "directory" || (name != "default.nix" && lib.strings.hasSuffix ".nix" name))
        ) (readDir dir)
      )
    );

}
