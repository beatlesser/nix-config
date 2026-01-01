#!/usr/bin/env bash
pkgs=()  
for pkg in "$@"; do
   pkgs+=("nixpkgs#$pkg")
done
nix shell ${pkgs[@]}
    
    
