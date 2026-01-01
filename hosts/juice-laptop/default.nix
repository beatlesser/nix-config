{
  exlib,
  inputs,
  ...
} @ args: let
  inherit (exlib) nixosSystem relativeToRoot;
  system = "x86_64-linux";
  host = "juice-laptop";
  host-modules = [
    ./config.nix
    ./boot.nix
    ./disk.nix
    ./optimization.nix
  ];
  hjem-modules = [
    (relativeToRoot "hjem")
  ];
in
  nixosSystem (
    args
    // {
      inherit
        system
        host
        host-modules
        hjem-modules
        ;
    }
  )
