{ mylib, ... }@args:
let

  inherit (mylib) mapToRoot nixosSystem;

  system = "x86_64-linux";

  host = "nixer";

  base-modules =
    mapToRoot [
      "secrets"
      "common/base"
      "common/nixos"
      "common/services"
    ]
    ++ [
      ./config.nix
      ./boot.nix
      ./disk.nix
      ./optimization.nix
    ];

  home-modules =
    mapToRoot [
      "home"
    ]
    ++ [ ./home.nix ];
in
nixosSystem (
  args
  // {
    inherit
      system
      host
      base-modules
      home-modules
      ;
  }
)
