#!/usr/bin/env bash
list=()  
for pkg in "$@"; do
   list+=("nixpkgs#$pkg")
done
nix shell ${list[@]}
    
    
