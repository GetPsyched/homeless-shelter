{ config, lib, options, pkgs, ... }:

with lib;

let
  cfg = config.programs.atlauncher;
  jsonFormat = pkgs.formats.json { };

  themeOptions = {
    "ATLauncher Dark" = "Dark";
    "ATLauncher Light" = "Light";
    "Monokai Pro" = "MonokaiPro";
    "Dracula Contrast" = "DraculaContrast";
    "Hiberbee Dark" = "HiberbeeDark";
    "Vuesion" = "Vuesion";
    "Material Palenight Contrast" = "MaterialPalenightContrast";
    "Arc Orange" = "ArcOrange";
    "Cyan Light" = "CyanLight";
    "High Tech Darkness" = "HighTechDarkness";
    "One Dark" = "OneDark";
  };
in
{
  meta.maintainers = [ maintainers.getpsyched ];

  options.programs.atlauncher = {
    enable = mkEnableOption "atlauncher";

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
      };
      description = ''
        Configuration written to
        {file}`$XDG_DATA_HOME/ATLauncher/configs/ATLauncher.json`.

        Rummage through
        <link xlink:href="https://github.com/ATLauncher/ATLauncher/blob/master/src/main/java/com/atlauncher/data/Settings.java"/>
        for supported values.
      '';
    };

    theme = mkOption {
      type = types.enum (attrsets.mapAttrsToList (name: value: name) themeOptions);
      default = "ATLauncher Dark";
      example = "One Dark";
      description = "The ATLauncher theme to use.";
    };
  };

  config =
    let
      mergedSettings = cfg.settings
        // optionalAttrs (cfg.theme != "ATLauncher Dark") { "theme" = "com.atlauncher.themes.${themeOptions.${cfg.theme}}"; };
    in
    mkIf cfg.enable {
      home.packages = [ cfg.package ];
      xdg.dataFile = mkIf (mergedSettings != { }) {
        "ATLauncher/configs/ATLauncher.json".source = jsonFormat.generate "atlauncher-config.json" mergedSettings;
      };
    };
}
