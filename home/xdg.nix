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
  defaultApps = {
    browser = [ "firefox.desktop" ];
    text = [ "neovim.desktop" ];
    audio = [ "mpv.desktop" ];
    video = [ "mpv.desktop" ];
    image = [ "imv-dir.desktop" ];
  };
  mimeMap = {
    browser = [
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
    text = [
      "text/plain"
      "application/x-wine-extension-ini"
    ];
    audio = [
      "audio/*"
    ];
    video = [
      "video/*"
    ];
    image = [
      "image/*"
      "image/gif"
      "image/jpeg"
      "image/png"
      "image/webp"
    ];
  };

  associations = builtins.listToAttrs (
    lib.flatten (
      lib.mapAttrsToList (key: map (type: lib.nameValuePair type defaultApps.${key})) mimeMap
    )
  );
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
