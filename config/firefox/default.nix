{ lib, pkgs, ... }:
{
  home-manager.users.primary = {
    programs.firefox = {
      enable = true;
      profiles.main =
        let
          profile = ./profile-primary;
        in
        lib.recursiveUpdate {
          isDefault = true;

          settings = {
            "browser.startup.page" = 3; # restore
            "distribution.searchplugins.defaultLocale" = "en-GB";
            "drm" = true;
            "general.useragent.locale" = "en-GB";
          };
        } (lib.optionalAttrs (builtins.pathExists profile) (import profile { inherit lib pkgs; }));
    };

    xdg.desktopEntries.chromium = {
      categories = [ "Application" ];
      name = "Chromium";
      exec = "${pkgs.ungoogled-chromium}/bin/chromium";
      genericName = "Browser";
      icon = "${pkgs.ungoogled-chromium}/share/icons/hicolor/48x48/apps/chromium.png";
      terminal = false;
    };
  };
  persist.state.homeDirectories = [ ".mozilla/firefox/main" ];
}
