{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkPackageOption
    mkOption
    mkIf
    ;
  jsonFormat = pkgs.formats.json {};
  tomlFormat = pkgs.formats.toml {};
  cfg = config.dots.programs.nix-search-tv;
in {
  options.dots.programs.nix-search-tv = {
    enable = mkEnableOption "nix-search-tv";
    package = mkPackageOption pkgs "nix-search-tv" {};
    enableTelevisionIntegration = mkEnableOption "television integration";
    settings = mkOption {
      inherit (jsonFormat) type;
      default = {};
      description = "nix-search-tv settings";
    };
  };
  config = mkIf cfg.enable {
    packages = [cfg.package];
    xdg.config.files."nix-search-tv/config.json" = mkIf (cfg.settings != {}) {
      generator = jsonFormat.generate "config.json";
      value = cfg.settings;
    };
    xdg.config.files."television/cable/nix-search-tv.toml" = mkIf cfg.enableTelevisionIntegration (
      let
        exe = lib.getExe cfg.package;
      in {
        generator = tomlFormat.generate "nix-search-tv.toml";
        value = {
          metadata = {
            name = "nix-search-tv";
            requirements = ["nix-search-tv"];
          };
          source = {
            command = "${exe} print";
          };
          preview = {
            command = "${exe} preview {}";
          };
        };
      }
    );
  };
}
