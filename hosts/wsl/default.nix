{
  mylib,
  inputs,
  ...
}@args:
let
  inherit (mylib) relativeToRoot nixosSystem;

  host = "wsl";

  system = "x86_64-linux";

  base-modules = [
    ./misc.nix
  ];

  home-modules =
    map relativeToRoot [
      "modules/home"
    ]
    ++ [ ./home.nix ];

  nixos-modules = map relativeToRoot [
    "modules/nixos/usr.nix"
    "modules/nixos/nix.nix"
    "modules/nixos/pkgs.nix"
    "modules/nixos/timezone.nix"
  ];
  extra-modules = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

in
nixosSystem (
  args
  // {
    inherit
      host
      system
      base-modules
      home-modules
      nixos-modules
      extra-modules
      ;
  }
)
