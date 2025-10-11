{ myvars, ... }:
let
  inherit (myvars) username email;
in
{
  #git config
  programs.git = {

    enable = true;

    lfs.enable = true;

    userName = "${username}";
    userEmail = "${email}";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;

      url = {
        "ssh://git@github.com/beatlesser" = {
          insteadOf = "https://github.com/beatlesser";
        };
      };
    };

    # A syntax-highlighting pager for git, diff, grep, and blame output
    delta = {
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
        # features => named groups of settings, used to keep related settings organized
        # features = "";
      };
    };
    aliases = {
      br = "branch";
      sw = "switch";
      rs = "reset";
      rt = "restore";
      st = "status";
      cm = "commit -m";
      ca = "commit -am";
      caa = "commit --amend -a --no-edit";
    };
  };
  #git gui wrtitten by go
  programs.lazygit.enable = true;
}
