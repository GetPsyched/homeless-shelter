{ config, lib, options, pkgs, ... }:

let
  cfg = config.programs.zed;

  inherit (lib) mkEnableOption mkPackageOption mkOption mkIf;
in
{
  options.programs.zed = {
    enable = mkEnableOption "zed";

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
    home.packages = [ cfg.package ];

    xdg.configFile."zed/settings.json".text = builtins.toJSON cfg.settings;
    xdg.configFile."zed/keymap.json".text = builtins.toJSON cfg.keymap;
  };

  meta.maintainers = with lib.maintainers; [ getpsyched ];
}
