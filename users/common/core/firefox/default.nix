{ config, lib, pkgs, ... }:
{
  persist.stateDirs = [ ".mozilla/firefox/main" ];

  programs.firefox = {
    enable = true;
    profiles.main =
      let
        ff-addons = import ./addons.nix { inherit pkgs; };
        profile = ./profile-${config.home.username};
      in
      lib.recursiveUpdate
        {
          isDefault = true;

          settings = {
            "browser.startup.page" = 3; # restore
            "distribution.searchplugins.defaultLocale" = "en-GB";
            "drm" = true;
            "general.useragent.locale" = "en-GB";
          };
        }
        (lib.optionalAttrs (builtins.pathExists profile) (import profile { inherit ff-addons pkgs; }));
  };

  xdg.desktopEntries.chromium = {
    categories = [ "Application" ];
    name = "Chromium";
    exec = "${pkgs.ungoogled-chromium}/bin/chromium";
    genericName = "Browser";
    icon = "${pkgs.ungoogled-chromium}/share/icons/hicolor/48x48/apps/chromium.png";
    terminal = false;
  };
}
