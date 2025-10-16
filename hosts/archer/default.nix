{ mylib, ... }@args:
let

  inherit (mylib) relativeRoot nixosSystem;

  system = "x86_64-linux";

  host = "archer";

  base-modules =
    map relativeRoot [
      "modules/base"
      "modules/nixos"
    ]
    ++ [
      ./configuraiton.nix
      ./hardware-configuration.nix
      ./optimization.nix
    ];

  home-modules = map relativeRoot [
    "modules/home"
  ]
  ++
  [./home.nix];
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
