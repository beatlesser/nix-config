{pkgs, ...}: {
  xdg.data.files."fcitx5/rime/default.custom.yaml" = {
    type = "copy";
    generator = (pkgs.formats.yaml {}).generate "default.custom.yaml";
    value = {
      patch = {
        "__include" = "rime_ice_suggestion:/";
        "__patch"."menu/page_size" = 5;
      };
    };
  };
}
