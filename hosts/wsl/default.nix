{
  mylib,
  ...
}@args:
let
  inherit (mylib) relativeToRoot nixosSystem;

  host = "wsl";
  system = "x86_64-linux";

  base-modules =
    map relativeToRoot [
      "modules/base/nix.nix"
      "modules/base/pkgs.nix"
      "modules/nixos/usr.nix"
      "modules/nixos/i18n.nix"
    ]
    ++ [
      ./misc.nix
    ];

  home-modules =
    map relativeToRoot [
      "modules/home"
    ]
    ++ [
      ./home.nix
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
      ;
  }
)
