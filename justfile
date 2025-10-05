set positional-arguments

@default:
    just --list

[linux]
[group('nix')]
@init:
    nix run github:nix-community/nix-init

[group('nix')]
@fmt:
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
    nh os switch . -H {{ host }}

[linux]
[group('nix')]
@fix:
    nix-store --repair --verify # --check-contents

[linux]
[group('nix')]
@genfacter:
    sudo nix run github:numtide/nixos-facter -- -o facter.json

@ns:
    tv nix-search-tv

@fd *pkgs:
    nh search {{ pkgs }}
