{ mylib, ... }@args:
let

  inherit (mylib) relativeToRoot nixosSystem;

  system = "x86_64-linux";

  host = "nixer";

  base-modules =
    map relativeToRoot [
      "common/base"
      "common/nixos"
      "common/services"
      "secrets"
    ]
    ++ [
      ./config.nix
      ./boot.nix
      ./disk.nix
      ./optimization.nix
    ];

  home-modules =
    map relativeToRoot [
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
