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

  cfg = config.programs.atlauncher;
  jsonFormat = pkgs.formats.json { };
in
{
  options.programs.atlauncher = {
    enable = mkEnableOption "ATLauncher";

    package = mkPackageOption pkgs "atlauncher" { };

    settings = mkOption {
      type = jsonFormat.type;
      default = { };
      example = {
        enableAnalytics = true;
        enableConsole = false;
        enableTrayMenu = false;
        firstTimeRun = false;
        keepLauncherOpen = false;
        theme = "com.atlauncher.themes.Dark";
      };
      description = ''
        Configuration written to
        {file}`$XDG_DATA_HOME/ATLauncher/configs/ATLauncher.json`.

        Rummage through
        <link xlink:href="https://github.com/ATLauncher/ATLauncher/blob/master/src/main/java/com/atlauncher/data/Settings.java"/>
        for supported values.
      '';
    };
  };

  config = mkIf cfg.enable {
    hjem.users.primary = {
      packages = [ cfg.package ];

      files = {
        ".local/share/ATLauncher/configs/ATLauncher.json".text = toJSON cfg.settings;
      };
    };
  };

  meta.maintainers = with lib.maintainers; [ getpsyched ];
}
