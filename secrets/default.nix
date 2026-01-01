{
  pkgs,
  config,
  exvars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  sops.defaultSopsFile = ../../secrets.yaml;
  sops.age.sshKeyPaths = ["/home/${exvars.username}/.ssh/id_ed25519"];
  sops.age.keyFile = "/home/${exvars.username}/.config/sops/age/keys.txt";
  sops.age.generateKey = true;
  sops.secrets."subscriptions/owo" = {
    owner = "root";
    mode = "0600";
  };
  #sops.secrets."cyer/pwd" = {
  #owner = config.users.users.${myvars.username}.name;
  #mode = "0600";
  #};
}
