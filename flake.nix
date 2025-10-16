{
  description = "uuuc's Nix Flakes";

  outputs =
    {
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib legacyPackages;
      inherit (lib) genAttrs mapAttrs;
      #import your vars and lib here
      myvars = import ./vars.nix;
      mylib = import ./lib { inherit lib; };
      #pass into your host config
      args = {
        inherit
          inputs
          lib
          mylib
          myvars
          ;
      };

      forAllSystems = genAttrs [
        "x86_64-linux"
      ];

    in
    {
      packages = forAllSystems (system: import ./pkgs legacyPackages.${system});
      formatter = forAllSystems (system: legacyPackages.${system}.nixfmt-tree);
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = mapAttrs (host: _: import ./hosts/${host} args) (builtins.readDir ./hosts);
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    inputs.hyprland.url = "github:hyprwm/Hyprland";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
  };
}
