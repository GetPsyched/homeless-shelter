{
  default = "DuckDuckGo";
  engines = {
    "Bing".metaData.hidden = true;
    "Google".metaData.alias = "@g";
    "DuckDuckGo".metaData.alias = "@ddg";

    "discord.py" = let version = "latest"; in {
      urls = [{
        template = "https://discordpy.readthedocs.io/en/${version}/search.html?q={searchTerms}";
      }];
      iconUpdateURL = "https://discordpy.readthedocs.io/en/stable/_static/discord_py_logo.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@dpy" ];
    };

    "HM Config" = let version = "latest"; in {
      urls = [{
        template = "https://mipmip.github.io/home-manager-option-search/?query={searchTerms}";
      }];
      iconUpdateURL = "https://github.com/mipmip/home-manager-option-search/blob/main/images/favicon.png";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@hm" ];
    };

    "Library Genesis" = {
      urls = [
        { template = "https://libgen.rs/search.php?req={searchTerms}"; } # non-fiction
        { template = "https://libgen.rs/fiction/?q={searchTerms}"; } # fiction
        { template = "https://libgen.rs/scimag/?q={searchTerms}"; } # scientific articles
        { template = "https://magzdb.org/makelist?t={searchTerms}"; } # magazines
      ];
      iconUpdateURL = "https://libgen.rs/favicon.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@libgen" ];
    };

    "MDN HTML" = {
      urls = [{ template = "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/{searchTerms}"; }];
      iconUpdateURL = "https://developer.mozilla.org/favicon-48x48.png";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@mdn" ];
    };

    "Nix" = {
      urls = [{ template = "https://mynixos.com/search?q={searchTerms}"; }];
      iconUpdateURL = "https://mynixos.com/favicon.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@nix" ];
    };

    "Nix Packages" = {
      urls = [{
        template = "https://search.nixos.org/packages";
        params = [
          { name = "channel"; value = "unstable"; }
          { name = "query"; value = "{searchTerms}"; }
          { name = "type"; value = "packages"; }
        ];
      }];
      iconUpdateURL = "https://nixos.org/favicon.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@np" ];
    };

    "NixOS Wiki" = {
      urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
      iconUpdateURL = "https://nixos.wiki/favicon.png";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@nw" ];
    };

    "Nix PR Tracker" = {
      urls = [{ template = "https://nixpk.gs/pr-tracker.html?pr={searchTerms}"; }];
      definedAliases = [ "@pr" ];
    };

    "Source Graph" = {
      urls = [{
        template = "https://sourcegraph.com/search";
        params = [
          { name = "q"; value = "context:@maan2003/nix {searchTerms}"; }
          { name = "groupBy"; value = "repo"; }
        ];
      }];
      iconUpdateURL = "https://sourcegraph.com/favicon.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@sg" ];
    };

    "Steam DB" = {
      urls = [{
        template = "https://steamdb.info/search";
        params = [
          { name = "a"; value = "app"; }
          { name = "type"; value = "1"; }
          { name = "q"; value = "{searchTerms}"; }
        ];
      }];
      definedAliases = [ "@sdb" ];
    };

    "TailwindCSS" = {
      urls = [{ template = "https://tailwindcss.com/docs/{searchTerms}"; }];
      iconUpdateURL = "https://tailwindcss.com/favicons/favicon-16x16.png";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@tw" ];
    };
  };
  force = true;
  order = [
    "DuckDuckGo"
    "Google"
  ];
}
