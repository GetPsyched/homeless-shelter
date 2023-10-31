{ options, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.atlauncher;
  jsonFormat = pkgs.formats.json { };

  mergedSettings = cfg.settings
    // optionalAttrs (cfg.theme == "ATLauncher Light") { "theme" = "com.atlauncher.themes.Light"; }
    // optionalAttrs (cfg.theme == "Monokai Pro") { "theme" = "com.atlauncher.themes.MonokaiPro"; }
    // optionalAttrs (cfg.theme == "Dracula Contrast") { "theme" = "com.atlauncher.themes.DraculaContrast"; }
    // optionalAttrs (cfg.theme == "Hiberbee Dark") { "theme" = "com.atlauncher.themes.HiberbeeDark"; }
    // optionalAttrs (cfg.theme == "Vuesion") { "theme" = "com.atlauncher.themes.Vuesion"; }
    // optionalAttrs (cfg.theme == "Material Palenight Contrast") { "theme" = "com.atlauncher.themes.MaterialPalenightContrast"; }
    // optionalAttrs (cfg.theme == "Arc Orange") { "theme" = "com.atlauncher.themes.ArcOrange"; }
    // optionalAttrs (cfg.theme == "Cyan Light") { "theme" = "com.atlauncher.themes.CyanLight"; }
    // optionalAttrs (cfg.theme == "High Tech Darkness") { "theme" = "com.atlauncher.themes.HighTechDarkness"; }
    // optionalAttrs (cfg.theme == "One Dark") { "theme" = "com.atlauncher.themes.OneDark"; };
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
      '';
    };

    theme = mkOption {
      type = types.enum [
        "ATLauncher Dark"
        "ATLauncher Light"
        "Monokai Pro"
        "Dracula Contrast"
        "Hiberbee Dark"
        "Vuesion"
        "Material Palenight Contrast"
        "Arc Orange"
        "Cyan Light"
        "High Tech Darkness"
        "One Dark"
      ];
      default = "ATLauncher Dark";
      example = "One Dark";
      description = "The ATLauncher theme to use.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    xdg.dataFile = mkIf (mergedSettings != { }) {
      "ATLauncher/configs/ATLauncher.json".source = jsonFormat.generate "atlauncher-config.json" mergedSettings;
    };
  };
}
