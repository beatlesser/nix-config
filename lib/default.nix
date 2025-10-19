{ lib, ... }:
let
  helper = import ./helper.nix { inherit lib; };
  nixosSystem = import ./nixosSystem.nix;
in
{

  inherit (helper) mapToRoot relativeToRoot mkImports;

  inherit nixosSystem;

}
