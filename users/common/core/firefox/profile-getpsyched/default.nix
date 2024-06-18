{ ff-addons, ... }:
{
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

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    "browser.uidensity" = 1;

    # sidebery
    "sidebar.position_start" = false; # sidebar on right side
  };
  userChrome = builtins.readFile ./userChrome.css;
}
