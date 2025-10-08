{ lib, ... }:
{
  inherit (import ./misc.nix { inherit lib; }) relativeToRoot mkImports;
  nixosSystem = import ./nixosSystem.nix;
}
