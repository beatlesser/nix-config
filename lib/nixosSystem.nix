{
  inputs,
  lib,
  system,
  host,
  base-modules ? (map lib.relativeRoot [ "modules/base" ]),
  home-modules ? (map lib.relativeRoot [ "modules/home" ]),
  myvars,
  mylib,
  ...
}:
let
  inherit (inputs)
    nixpkgs
    nixpkgs-stable
    home-manager
    nur
    nix-index-database
    nix-flatpak
    ;

  inherit (myvars) username;

  baseArgs = {
    inherit
      inputs
      system
      host
      myvars
      mylib
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

  shared-modules = [
    nur.modules.nixos.default
    nix-flatpak.nixosModules.nix-flatpak
    nix-index-database.nixosModules.nix-index
  ];
in
lib.nixosSystem {
  inherit system specialArgs;
  modules =
    shared-modules
    ++ base-modules
    ++ (lib.optionals ((lib.lists.length home-modules) > 0) [
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "home-manager.backup";
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.sharedModules = [
          nix-index-database.homeModules.nix-index
          nix-flatpak.homeManagerModules.nix-flatpak
        ];
        home-manager.users."${username}".imports = home-modules;
      }
    ]);
}
