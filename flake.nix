{
  description = "uuuc's Nix Flakes";

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      inherit (self) outputs;
      inherit (nixpkgs) lib legacyPackages;
      #import your vars and lib here
      myvars = import ./vars.nix;
      mylib = import ./lib.nix { inherit lib; };
      #add your hosts here
      hosts = [ "wsl" ];
      #add your systems here
      forAllSystems = lib.genAttrs [
        "x86_64-linux"
      ];
      mkNixOSConfig =
        host:
        lib.nixosSystem {
          specialArgs = {
            inherit
              inputs
              outputs
              host
              mylib
              myvars
              ;
          };
          modules = [ ./hosts/${host} ];
        };
    in
    {
      packages = forAllSystems (system: import ./pkgs legacyPackages.${system});
      formatter = forAllSystems (system: legacyPackages.${system}.nixfmt-tree);
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = lib.genAttrs hosts (host: mkNixOSConfig host);
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

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

    nur.url = "github:nix-community/nur";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    deploy-rs.url = "github:serokell/deploy-rs";
    sops-nix.url = "github:Mic92/sops-nix";
  };
}
