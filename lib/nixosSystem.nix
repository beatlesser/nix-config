{
  inputs,
  lib,
  system,
  host,
  base-modules,
  home-modules ? [ ],
  myvars,
  mylib,
  ...
}:
let
  inherit (myvars) username;

  inherit (inputs)
    home-manager
    disko
    sops-nix
    nur
    nix-index-database
    nix-flatpak
    lanzaboote
    ;

  baseArgs = {
    inherit
      system
      host
      myvars
      mylib
      ;
  };

  specialArgs = inputs // baseArgs;

  shared-modules = [
    nur.modules.nixos.default
    nix-flatpak.nixosModules.nix-flatpak
    nix-index-database.nixosModules.nix-index
    disko.nixosModules.default
    sops-nix.nixosModules.default
    lanzaboote.nixosModules.lanzaboote
  ];

in

lib.nixosSystem {
  inherit system specialArgs;
  modules =
    shared-modules
    ++ base-modules
    ++ lib.optionals ((lib.lists.length home-modules) > 0) [
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
    ];
}
