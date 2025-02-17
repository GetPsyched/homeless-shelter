{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption mkPackageOption;
  inherit (lib.types) bool;

  cfg = config.programs.helix;
  toml = pkgs.formats.toml { };
in
{
  options.programs.helix = {
    enable = mkEnableOption "Helix";

    package = mkPackageOption pkgs "helix" { };

    defaultEditor = mkOption {
      type = bool;
      default = false;
    };

    settings = mkOption {
      type = toml.type;
      default = { };
      example = {
        theme = "tokyonight";
      };
    };

    languages = mkOption {
      type = toml.type;
      default = [ ];
      example = [
        {
          nixd.command = lib.getExe pkgs.nixd;
        }
      ];
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.mainuser} = {
      home.packages = [ cfg.package ];

      home.sessionVariables = mkIf cfg.defaultEditor { EDITOR = lib.getExe cfg.package; };

      xdg.configFile."helix/config.toml".source = toml.generate "config.toml" cfg.settings;
      xdg.configFile."helix/languages.toml".source = toml.generate "languages.toml" cfg.languages;
    };
  };

  meta.maintainers = with lib.maintainers; [ getpsyched ];
}
