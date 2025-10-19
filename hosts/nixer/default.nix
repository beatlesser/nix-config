{ mylib, ... }@args:
let

  inherit (mylib) relativeToRoot nixosSystem;

  system = "x86_64-linux";

  host = "nixer";

  base-modules =
    map relativeToRoot [
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
    map relativeToRoot [
      "home/xdg.nix"
      "home/starship.nix"
      "home/shell.nix"
      "home/clip.nix"
      "home/git.nix"
      "home/neovim.nix"
      "home/fcitx5.nix"
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
