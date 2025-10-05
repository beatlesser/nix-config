set positional-arguments

@default:
    just --list

[linux]
[group('nix')]
@init:
    nix run github:nix-community/nix-init

[group('nix')]
@fmt:
  # format the nix files in this repo
  nix fmt

[linux]
[group('nix')]
@up *inputs:
    nix flake update {{ inputs }} --commit-lock-file

[linux]
[group('nix')]
@clean:
    #Wipe out NixOS's history
    sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d

    # Wipe out home-manager's history
    nix profile wipe-history --profile "$XDG_STATE_HOME/nix/profiles/home-manager" --older-than 7d

[linux]
[group('nix')]
@gc:
    sudo nix-collect-garbage --delete-older-than 7d

    nix-collect-garbage --delete-older-than 7d

[linux]
[group('nix')]
repl:
    nix repl -f flake:nixpkgs

[linux]
[group('nix')]
@sh *pkgs = "git neovim":
    source scripts/prefix.sh $@

[linux]
[group('nix')]
@dev env="dev":
    nix develop .#{{ env }}

[linux]
[group('nix')]
@deploy host="wsl":
    sudo nixos-rebuild switch --flake .#{{ host }}

[linux]
[group('nix')]
@nh-deploy host="wsl":
    sudo nh switch --flake .#{{ host }}

[linux]
[group('nix')]
@fix:
    nix-store --repair --verify # --check-contents

[linux]
[group('nix')]
@genfacter:
    sudo nix run github:numtide/nixos-facter -- -o facter.json

[linux]
[group('nix')]
@fast-deploy host="wsl":
    nix run github:Mic92/nix-fast-build -- --flake .#nixosConfigurations.{{ host }}.config.system.build.toplevel --skip-cached --eval-workers 2 --eval-max-memory-size 15360

[linux]
[group('nix')]
@fast-build pkg="":
    nix run github:Mic92/nix-fast-build -- --flake .#packages.x86_64-linux.{{ pkg }} --eval-max-memory-size 15360

@ns:
    nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history

@fd *pkgs:
    nh search {{ pkgs }}
