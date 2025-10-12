{
  sops-nix,
  pkgs,
  config,
  myvars,
  ...
}:
let
  inherit (myvars) username;
in
{
  imports = [
    sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    sops
  ];

  # This will add secrets.yml to the nix store
  # You can avoid this by adding a string to the full path instead, i.e.
  # sops.defaultSopsFile = "/root/.sops/secrets/example.yaml";
  # sops.defaultSopsFile = "/home/${username}/loneros-nixos/secrets/secrets.yaml";
  sops.defaultSopsFile = ./secrets.yaml;
  # This will automatically import SSH keys as age keys
  sops.age.sshKeyPaths = [ "/home/${username}/.ssh/id_ed25519" ];
  # This is using an age key that is expected to already be in the filesystem
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  # This will generate a new key if the key specified above does not exist
  sops.age.generateKey = true;

  # This is the actual specification of the secrets.
}
