set positional-arguments

@default:
    just --list

@install target:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko -f .#{{ target }} --option substituters "https://mirrors.ustc.edu.cn"
    nixos-install --flake .#{{ target }}

@install-remote target ip:
    nix --experimental-features "nix-command flakes" run github:nix-community/nixos-anywhere -- -i ~/.ssh/id_ed25519 --flake .#{{ target }} root@{{ ip }}

@up *inputs:
    nix flake update {{ inputs }} --commit-lock-file

@clean:
    #Wipe out NixOS's history
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

    # Wipe out home-manager's history
    nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager" --older-than 7d

@gc:
    sudo nix-collect-garbage --delete-older-than 7d

    nix-collect-garbage --delete-older-than 7d

repl:
    nix repl -f flake:nixpkgs

@shell *pkgs = "git neovim":
    source scripts/prefix.sh $@

@dev env="dev":
    nix develop .#{{ env }}

@switch host="nixer":
   sudo nixos-rebuild switch --flake .#{{ host }} 

@fix:
    nix-store --repair --verify # --check-contents

@facter:
    sudo nix run github:numtide/nixos-facter -- -o facter.json

@ns:
    tv nix-search-tv
