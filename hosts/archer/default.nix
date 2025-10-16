{ mylib, ... }@args:
let

  inherit (mylib) relativeToRoot nixosSystem;

  system = "x86_64-linux";

  host = "archer";

  base-modules =
    map relativeToRoot [
      "modules/base"
      "modules/nixos"
    ]
    ++ [
      ./configuration.nix
      ./hardware-configuration.nix
      ./optimization.nix
    ];

  home-modules =
    map relativeToRoot [
      "modules/home"
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
