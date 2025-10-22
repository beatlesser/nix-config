{ myvars, ... }:
let
  inherit (myvars) username email;
in
{
  #git config
  programs = {
    git = {

      enable = true;
      lfs.enable = true;

      settings = {
        user = {
          name = "${username}";
          email = "${email}";
        };

        alias = {
          br = "branch";
          sw = "switch";
          rs = "reset";
          rt = "restore";
          st = "status";
          df = "diff";
          ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
          cm = "commit -m";
          ca = "commit -am";
          caa = "commit --amend -a --no-edit";
        };

        init.defaultBranch = "main";

        pull.rebase = true;
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
    #git gui wrtitten by go
    lazygit.enable = true;
  };
}
