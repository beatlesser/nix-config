{
  description = "Beatlesser's Nix Flakes";
  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib legacyPackages;
    inherit (lib) genAttrs mapAttrs;
    #import your vars and lib here
    exvars = import ./vars.nix;
    exlib = import ./lib {inherit lib;};
    #pass into your host config
    args = {
      inherit
        inputs
        lib
        exlib
        exvars
        ;
    };
    forEachSystem = genAttrs [
      "x86_64-linux"
    ];
  in {
    formatter = forEachSystem (system: legacyPackages.${system}.alejandra);
    nixosConfigurations = mapAttrs (host: _: import ./hosts/${host} args) (builtins.readDir ./hosts);
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
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
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/latest";
    impermanence.url = "github:nix-community/impermanence";
    sops-nix.url = "github:Mic92/sops-nix";
  };
}
