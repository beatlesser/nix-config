{
  inputs,
  lib,
  system,
  host,
  nixos-modules,
  home-modules ? [ ],
  extra-modules ? [ ],
  myvars,
  mylib,
  ...
}:
let
  inherit (inputs) nixpkgs nixpkgs-stable home-manager;

  baseArgs = {
    inherit
      inputs
      system
      host
      mylib
      myvars
      ;
  };

  pkgArgs = {
    unstable = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  specialArgs = baseArgs // pkgArgs;
in
lib.nixosSystem {
  inherit system specialArgs;
  modules =
    nixos-modules
    ++ (lib.optionals ((lib.lists.length home-modules) > 0) [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "home-manager.backup";
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users."${myvars.username}".imports = home-modules;
      }
    ])
    ++ extra-modules;
}
