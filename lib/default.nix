{lib, ...}: let
  func = import ./func.nix {inherit lib;};
  nixosSystem = import ./nixosSystem.nix;
in
  func
  // {
    inherit nixosSystem;
  }
