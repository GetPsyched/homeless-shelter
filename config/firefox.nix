{ lib, pkgs, ... }:
{
  hjem.users.primary.xdg.mime-apps.default-applications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };

  programs.firefox = {
    enable = true;

    autoConfig =
      let
        mkUserJs = prefs: ''
          ${lib.concatStrings (
            lib.mapAttrsToList (name: value: ''
              lockPref("${name}", ${builtins.toJSON value});
            '') prefs
          )}
        '';
      in
      mkUserJs {
        # Dark mode
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        "layout.css.prefers-color-scheme.content-override" = 0;

        # Locales
        "general.useragent.locale" = "en-GB";
        "intl.accept_languages" = lib.concatStringsSep "," [ "en-GB" ];
        "intl.locale.requested" = lib.concatStringsSep "," [ "en-GB" ];

        "browser.tabs.groups.enabled" = true;
        "browser.uidensity" = 1;
        "browser.urlbar.suggest.calculator" = true;

        "sidebar.expandOnHover" = true;
        "sidebar.visbility" = "hide";
        "sidebar.main.tools" = lib.concatStringsSep "," [ "bookmarks" ];
        "sidebar.position_start" = false;
        "sidebar.revamp" = true;
        "sidebar.revamp.round-content-area" = true;
        "sidebar.verticalTabs" = true;
      };
    languagePacks = [ "en-GB" ];
    policies = {
      Bookmarks =
        let
          mkBookmarksFolder =
            Folder: Placement: bookmarks:
            map (bookmark: bookmark // { inherit Folder Placement; }) bookmarks;
        in
        (mkBookmarksFolder "image-utilities" "menu" [
          {
            Title = "colour-picker";
            URL = "https://imagecolorpicker.com";
          }
          {
            Title = "svg-repo";
            URL = "https://www.svgrepo.com";
          }
          {
            Title = "palette";
            URL = "https://www.hexcolortool.com";
          }
        ]);
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DownloadDirectory = "\${home}";
      ExtensionSettings =
        let
          mkExtension = id: attrs: {
            name = id;
            value = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
            }
            // attrs;
          };
        in
        {
          "*" = {
            allowed_types = [ "extension" ];
            default_area = "menupanel";
            installation_mode = "blocked";
          };
        }
        // lib.listToAttrs [
          (mkExtension "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" { }) # Stylus
          (mkExtension "@testpilot-containers" { })
          (mkExtension "addon@darkreader.org" { default_area = "navbar"; })
          (mkExtension "amptra@keepa.com" { })
          (mkExtension "firefox@tampermonkey.net" { })
          (mkExtension "sponsorBlocker@ajay.app" { })
          (mkExtension "uBlock0@raymondhill.net" { })
        ];
      Homepage.StartPage = "previous-session";
      RequestedLocales = [ "en-GB" ];
      SearchEngines = {
        Add = [
          # Nix
          {
            Name = "Nix Packages";
            URLTemplate = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}";
            IconURL = "https://nixos.org/favicon.ico";
            Alias = "@np";
          }
          {
            Name = "Nix Package Versions";
            URLTemplate = "https://lazamar.co.uk/nix-versions/?channel=nixpkgs-unstable&package={searchTerms}";
            Alias = "@nixver";
          }
          {
            Name = "NixOS Options";
            URLTemplate = "https://search.nixos.org/options?channel=unstable&query={searchTerms}";
            IconURL = "https://nixos.org/favicon.ico";
            Alias = "@no";
          }
          {
            Name = "Hjem Options";
            URLTemplate = "https://hjem.feel-co.org/search.html?q={searchTerms}";
            Alias = "@hj";
          }
          {
            Name = "Hjem Rum Options";
            URLTemplate = "https://snugnug.github.io/hjem-rum";
            IconURL = "https://snugnug.github.io/hjem-rum/favicon.ico";
            Alias = "@hjr";
          }
          {
            Name = "Nixpkgs PR Tracker";
            URLTemplate = "https://nixpkgs-tracker.ocfox.me?pr={searchTerms}";
            IconURL = "https://ocfox.me/favicon.ico";
            Alias = "@pr";
          }
          {
            Name = "Sourcegraph";
            URLTemplate = "https://sourcegraph.com/search?q=context:@maan2003/nix {searchTerms}&groupBy=repo";
            IconURL = "https://sourcegraph.com/favicon.ico";
            Alias = "@sg";
          }

          # Games
          {
            Name = "How Long To Beat";
            URLTemplate = "https://howlongtobeat.com/?q={searchTerms}";
            IconURL = "https://www.howlongtobeat.com/favicon.ico";
            Alias = "@hltb";
          }
          {
            Name = "ProtonDB";
            URLTemplate = "https://www.protondb.com/search?q={searchTerms}";
            IconURL = "https://www.protondb.com/favicon.ico";
            Alias = "@pdb";
          }
          {
            Name = "SteamDB";
            URLTemplate = "https://www.steamdb.info/search?q={searchTerms}&a=app&type=1";
            IconURL = "https://www.steamdb.info/favicon.ico";
            Alias = "@sdb";
          }

          # Development
          {
            Name = "discord.py";
            URLTemplate = "https://discordpy.readthedocs.io/en/latest/search.html?q={searchTerms}";
            IconURL = "https://discordpy.readthedocs.io/en/stable/_static/discord_py_logo.ico";
            Alias = "@dpy";
          }
          {
            Name = "MDN HTML";
            URLTemplate = "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/{searchTerms}";
            IconURL = "https://developer.mozilla.org/favicon-48x48.png";
            Alias = "@mdn";
          }
          {
            Name = "React Icons";
            URLTemplate = "https://react-icons.github.io/react-icons/search/#q={searchTerms}";
            IconURL = "https://react-icons.github.io/react-icons/favicon.ico";
            Alias = "@ri";
          }
          {
            Name = "TailwindCSS";
            URLTemplate = "https://tailwindcss.com/docs/{searchTerms}";
            IconURL = "https://tailwindcss.com/favicons/favicon-16x16.png";
            Alias = "@tw";
          }

          # Miscellaneous
          {
            Name = "Library Genesis";
            URLTemplate = "https://libgen.rs/search.php?req={searchTerms}";
            IconURL = "https://libgen.rs/favicon.ico";
            Alias = "@libgen";
          }
        ];
        Default = "DuckDuckGo";
        OfferToSaveLogins = false;
        PreventInstalls = true;
        Remove = [
          "Bing"
          "eBay"
          "Wikipedia (en)"
        ];
      };
    };
  };

  persist.state.homeDirectories = [ ".mozilla/firefox/primary" ];
  persist.state.homeFiles = [ ".mozilla/firefox/profiles.ini" ];

  # just in case
  users.users.primary.packages = [ pkgs.ungoogled-chromium ];
}
