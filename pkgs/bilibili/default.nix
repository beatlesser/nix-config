{
  lib,
  stdenv,
  fetchurl,
  electron,
  makeWrapper,
  ...
}@args:
stdenv.mkDerivation rec {
  pname = "bilibili";
  version = "1.2.1-1";

  src = fetchurl {
    url = "https://github.com/msojocs/bilibili-linux/releases/download/v1.2.1-1/io.github.msojocs.bilibili_1.2.1-1_amd64.deb";
    sha256 = "sha256-t/igezm0ipkOkKION8qTYGK9f6qI3c4iPuS/wWrMywQ=";
  };

  unpackPhase = ''
    ar x ${src}
    tar xf data.tar.xz
  '';

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin

    cp -r usr/share $out/share

    sed -i "s|Exec=.*|Exec=$out/bin/bilibili|" $out/share/applications/*.desktop

    cp -r opt/apps/io.github.msojocs.bilibili/files/bin/app $out/opt

    makeWrapper ${electron}/bin/electron $out/bin/bilibili \
     --argv0 "bilibili" \
     --add-flags "$out/opt/app.asar"
  '';
}
