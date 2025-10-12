{ mylib, ... }@args:
let

  inherit (mylib) relativeRoot nixosSystem;

  system = "x86_64-linux";
  host = "vm";

  base-modules =
    map relativeRoot [
      "modules/base"
      "modules/nixos"
    ]
    ++ [
      ./optimization.nix
      ./disko.nix
    ];

  home-modules = map relativeRoot [
    "modules/nixos"
  ];
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
