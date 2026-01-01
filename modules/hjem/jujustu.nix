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
  tomlFormat = pkgs.formats.toml {};
  cfg = config.dots.programs.jujutsu;
in {
  options.dots.programs.jujutsu = {
    enable = mkEnableOption "jujutsu";
    package = mkPackageOption pkgs "jujutsu" {};
    settings = mkOption {
      inherit (tomlFormat) type;
      default = {};
      description = "jujutsu settings";
    };
  };

  config = mkIf cfg.enable {
    packages = [cfg.package];
    files.".jjconfig.toml" = mkIf (cfg.settings != {}) {
      generator = tomlFormat.generate ".jjconfig.toml";
      value = cfg.settings;
    };
  };
}
