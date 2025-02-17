{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (builtins) toJSON;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption mkPackageOption;

  cfg = config.programs.zed;
in
{
  options.programs.zed = {
    enable = mkEnableOption "Zed";

    package = mkPackageOption pkgs "zed-editor" { };

    settings = mkOption {
      type = (pkgs.formats.json { }).type;
      default = { };
      example = {
        theme = "Ayu Dark";
      };
    };

    keymap = mkOption {
      type = (pkgs.formats.json { }).type;
      default = [ ];
      example = [
        {
          context = "Editor && vim_mode == insert";
          bindings = {
            f9 = "vim::NormalBefore";
          };
        }
      ];
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.primary = {
      home.packages = [ cfg.package ];

      xdg.configFile."zed/settings.json".text = toJSON cfg.settings;
      xdg.configFile."zed/keymap.json".text = toJSON cfg.keymap;
    };
  };

  meta.maintainers = with lib.maintainers; [ getpsyched ];
}
