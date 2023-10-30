{ options, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.atlauncher;
  jsonFormat = pkgs.formats.json { };
in
{
  meta.maintainers = [ maintainers.getpsyched ];

  options.programs.atlauncher = {
    enable = mkEnableOption "atlauncher";

    package = mkPackageOption pkgs "atlauncher" { };

    settings = mkOption {
      type = jsonFormat.type;
      default = { };
      example = literalExpression ''
        {
          enableAnalytics = true;
          enableConsole = false;
          enableFeralGamemode = true;
          enableTrayMenu = false;
          keepLauncherOpen = false;
        };
      '';
      description = ''
        Configuration written to
        {file}`$XDG_DATA_HOME/ATLauncher/configs/ATLauncher.json`.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.dataFile = mkIf (cfg.settings != { }) {
      "ATLauncher/configs/ATLauncher.json".source = jsonFormat.generate "atlauncher-config.json" cfg.settings;
    };
  };
}
