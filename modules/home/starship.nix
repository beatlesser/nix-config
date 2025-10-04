{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      format = lib.concatStrings [
        "[░▒▓](#a3aed2)"
        "$os"
        "[](bg:#769ff0 fg:#a3aed2)"
        "$directory"
        "[](fg:#769ff0 bg:#394260)"
        "$git_branch"
        "$git_status"
        "[](fg:#394260 bg:#212736)"
        "$nodejs"
        "$rust"
        "$golang"
        "[](fg:#212736 bg:#1d2230)"
        "$time"
        "[ ](fg:#1d2230)"
        "\n$character"
      ];
      directory = {
        disabled = false;
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };
      os = {
        disabled = false;
        format = "[ $symbol ]($style)";
        style = "bg:#a3aed2 fg:#090c0c";
        symbols = {
          Windows = "";
          Ubuntu = "󰕈";
          Macos = "󰀵";
          Linux = "󰌽";
          Fedora = "󰣛";
          Android = "";
          Arch = "󰣇";
          NixOS = "";
          Debian = "󰣚";
        };
      };

      git_branch = {
        disabled = false;
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };

      git_status = {
        disabled = false;
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };
      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:#1d2230";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
    };
  };
}
