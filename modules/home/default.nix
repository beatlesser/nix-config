{
  lib,
  host,
  mylib,
  myvars,
  inputs,
  outputs,
  ...
}:
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
  };
}
