{
  lib,
  host,
  mylib,
  myvars,
  inputs,
  outputs,
  ...
}:
let
  inherit (myvars) username;
  inherit (mylib) relativeToRoot;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    backupFileExtension = "hm-backup";
    useUserPackages = true;
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        host
        mylib
        myvars
        ;
    };
    sharedModules = [
      ./neovim.nix
      ./starship.nix
      ./doc.nix
      ./shell.nix
    ];
    users.${username} = relativeToRoot "hosts/${host}/home.nix";
  };
}
