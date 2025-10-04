{
  lib,
  inputs,
  outputs,
  username,
  email,
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
        username
        email
        ;
    };
    users.${username} = {
      programs.home-manager.enable = true;
      home = {
        inherit username;
        homeDirectory = lib.mkForce "/home/${username}";
        stateVersion = "25.05";
      };
      imports = [
        ./neovim.nix
        ./starship.nix
      ];
    };
  };

}
