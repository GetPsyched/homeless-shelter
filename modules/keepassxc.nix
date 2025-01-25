{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib.generators) toINI;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption mkPackageOption;

  cfg = config.programs.keepassxc;
  ini = pkgs.formats.ini { };
in
{
  options.programs.keepassxc = {
    enable = mkEnableOption "KeepassXC";

    package = mkPackageOption pkgs "keepassxc" { };

    settings = mkOption {
      type = ini.type;
      default = { };
      example = {
        Browser.Enabled = true;
        GUI.ApplicationTheme = "dark";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.mainuser} = {
      home.packages = [ cfg.package ];

      xdg.configFile."keepassxc/keepassxc.ini".text = toINI { } cfg.settings;
    };
  };
}
