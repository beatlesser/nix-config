{
  mylib,
  inputs,
  ...
}@args:
let
  inherit (mylib) relativeToRoot nixosSystem;

  host = "wsl";

  system = "x86_64-linux";

  nixos-modules = map relativeToRoot [
    "modules/base/nix.nix"
    "modules/base/pkgs.nix"
    "modules/nixos/usr.nix"
    "modules/nixos/i18n.nix"
  ];

  home-modules =
    map relativeToRoot [
      "modules/home"
    ]
    ++ [ ./home.nix ];

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
      nixos-modules
      home-modules
      extra-modules
      ;
  }
)
