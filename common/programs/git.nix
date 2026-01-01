{exvars, ...}: let
  inherit (exvars) username email;
in {
  programs.git = {
    enable = true;
    config = {
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
}
