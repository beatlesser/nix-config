set positional-arguments

@default:
    just --list

@install target:
    nix --experimental-features "nix-command flakes" run github:nix-community/disko -- -m disko -f .#{{ target }}
    nixos-install \
        --option substituters "https://mirrors.ustc.edu.cn/nix-channels/store https://cache.garnix.io" \
        --option trusted-public-keys "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" \
        --flake .#{{ target }}

@up *inputs:
    nix flake update {{ inputs }} --commit-lock-file

@wipe:
    #Wipe out NixOS's history
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

@gc:
    sudo nh clean all

@repl:
    nix repl -f flake:nixpkgs

@shell *pkgs = "git neovim":
    source scripts/prefix.sh $@

@dev env="dev":
    nix develop .#{{ env }}

@switch host="juice-laptop":
   nh os switch . -H {{ host }}

@fix:
    nix-store --repair --verify # --check-contents

@facter:
    sudo nix run github:numtide/nixos-facter -- -o facter.json

@ns:
    tv nix-search-tv
