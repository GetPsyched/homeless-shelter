{ ff-addons, ... }:
{
  isDefault = true;

  bookmarks = import ./bookmarks.nix;
  extensions = with ff-addons; [
    darkreader
    hoppscotch
    keepa
    multi-account-containers
    sidebery
    sponsorblock
    stylus
    tampermonkey
    ublock-origin
  ];
  search = import ./search.nix;
  settings = {
    "extensions.update.autoUpdateDefault" = false;

    # Dark mode
    "browser.theme.content-theme" = 0;
    "browser.theme.toolbar-theme" = 0;
    "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
    "layout.css.prefers-color-scheme.content-override" = 0;

    "browser.startup.page" = 3; # restore
    "distribution.searchplugins.defaultLocale" = "en-GB";
    "drm" = true;
    "general.useragent.locale" = "en-GB";
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    "browser.uidensity" = 1;

    # sidebery
    "sidebar.position_start" = false; # sidebar on right side
  };
  userChrome = builtins.readFile ./userChrome.css;
}
