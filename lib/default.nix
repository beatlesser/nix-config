{ lib, ... }:
let
  helper = import ./helper.nix { inherit lib; };
  nixosSystem = import ./nixosSystem.nix;
in
{

  inherit (helper) relativeToRoot mkImports;

  inherit nixosSystem;

}
