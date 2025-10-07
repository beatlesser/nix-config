{
  lib,
  host,
  myLib,
  myVars,
  inputs,
  outputs,
  ...
}:
let
  inherit (myVars) username;
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
        myLib
        myVars
        ;
    };
    users.${username} = {
      programs.home-manager.enable = true;
      imports = [
        ./xdg.nix
        ./shell.nix
        ./neovim.nix
        ./starship.nix
      ];
      home = {
        inherit username;
        homeDirectory = lib.mkForce "/home/${username}";
        stateVersion = "25.05";
      };
    };
  };

}
