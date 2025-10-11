{ pkgs, myvars, ... }:
let
  inherit (myvars) username email;
in
{
  programs = {

    #shell
    fish = {
      enable = true;
    };

    #documentation
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = false;
          auto_update_interval_hours = 720;
        };
      };
    };

    #git gui wrtitten by go
    lazygit.enable = true;

    #git config
    git = {

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

    fastfetch.enable = true;

    ripgrep.enable = true;

    fd.enable = true;

    bat.enable = true;

    lsd.enable = true;

    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    television = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    nix-search-tv = {
      enable = true;
      enableTelevisionIntegration = true;
    };
  };
  #if programs do not support,add pkgs manual
  home.packages = with pkgs; [
    duf
  ];
}
