{ stdenv, lib, ... }:
stdenv.mkDerivation {
  pname = "hello";
  version = "1.0";

  src = ./src;

  buildPhase = ''
      mkdir -p build
      gcc -o build/hello $src/main.c
  '';

  installPhase = ''
      mkdir -p $out/bin
      cp build/hello $out/bin/
  '';
}
