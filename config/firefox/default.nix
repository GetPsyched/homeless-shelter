{ lib, pkgs, ... }:
{
  home-manager.users.primary.programs.firefox = {
    enable = true;
    profiles.primary =
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

  persist.state.homeDirectories = [ ".mozilla/firefox/primary" ];

  # just in case
  users.users.primary.packages = [ pkgs.ungoogled-chromium ];
}
