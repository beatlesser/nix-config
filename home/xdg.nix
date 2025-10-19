# XDG stands for "Cross-Desktop Group", with X used to mean "cross".
# It's a bunch of specifications from freedesktop.org intended to standardize desktops and
# other GUI applications on various systems (primarily Unix-like) to be interoperable:
#   https://www.freedesktop.org/wiki/Specifications/
{
  config,
  pkgs,
  lib,
  ...
}:
let
  openInBrowser = [
    "application/json"
    "application/pdf"
    "text/html"
    "text/xml"
    "application/xml"
    "application/xhtml+xml"
    "application/xhtml_xml"
    "application/rdf+xml"
    "application/rss+xml"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xht"
    "application/x-extension-xhtml"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
  ];
  openInEditor = [
    "text/plain"
    "application/x-wine-extension-ini"
  ];
  openInPlayer = [
    "audio/*"
    "video/*"
  ];
  openInPreviewer = [
    "image/*"
    "image/gif"
    "image/jpeg"
    "image/png"
    "image/webp"
  ];

  associations =
    lib.genAttrs openInBrowser (_: [ "firefox.desktop" ])
    // lib.genAttrs openInEditor (_: [ "neovim.desktop" ])
    // lib.genAttrs openInplayer (_: [ "mpv.desktop" ])
    // lib.genAttrs openInPreviewer (_: [ "imv-dir.desktop" ]);
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
  };
}
