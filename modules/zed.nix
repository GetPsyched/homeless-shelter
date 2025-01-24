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
    hjem.users.primary = {
      packages = [ cfg.package ];

      files = {
        ".config/zed/settings.json".text = toJSON cfg.settings;
        ".config/zed/keymap.json".text = toJSON cfg.keymap;
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ getpsyched ];
}
