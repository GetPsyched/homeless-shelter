{
  default = "DuckDuckGo";
  engines = {
    "Bing".metaData.hidden = true;
    "Google".metaData.alias = "@g";
    "DuckDuckGo".metaData.alias = "@ddg";
  }
  # Nix stuff
  // {
    "Home Manager Options" = {
      urls = [{
        template = "https://home-manager-options.extranix.com/?query={searchTerms}";
      }];
      iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@hmo" ];
    };

    "NixOS Options" = {
      urls = [{
        template = "https://search.nixos.org/options";
        params = [
          { name = "channel"; value = "unstable"; }
          { name = "query"; value = "{searchTerms}"; }
        ];
      }];
      iconUpdateURL = "https://nixos.org/favicon.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@no" ];
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
  }
  # Miscellaneous
  // {
    "discord.py" = let version = "latest"; in {
      urls = [{
        template = "https://discordpy.readthedocs.io/en/${version}/search.html?q={searchTerms}";
      }];
      iconUpdateURL = "https://discordpy.readthedocs.io/en/stable/_static/discord_py_logo.ico";
      updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
      definedAliases = [ "@dpy" ];
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

    "Proton DB" = {
      urls = [{ template = "https://www.protondb.com/search?q={searchTerms}"; }];
      definedAliases = [ "@pdb" ];
    };

    "React Icons" = {
      urls = [{ template = "https://react-icons.github.io/react-icons/search/#q={searchTerms}"; }];
      definedAliases = [ "@ri" ];
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
