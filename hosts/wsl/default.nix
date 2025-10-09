{
  mylib,
  inputs,
  ...
}@args:
let
  inherit (mylib) relativeToRoot nixosSystem;

  host = "wsl";

  system = "x86_64-linux";

  base-modules = map relativeToRoot [
    "modules/base/nix.nix"
    "modules/base/pkgs.nix"
  ];

  home-modules =
    map relativeToRoot [
      "modules/home"
    ]
    ++ [ ./home.nix ];

  nixos-modules = map relativeToRoot [
    "modules/nixos/usr.nix"
    "modules/nixos/i18n.nix"
  ];

  extra-modules = [
    ./misc.nix
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
