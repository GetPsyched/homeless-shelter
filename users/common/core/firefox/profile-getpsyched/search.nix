{
  default = "DuckDuckGo";
  engines =
    let
      mkEngine =
        {
          alias,
          iconUpdateURL ? "",
          params ? [ ],
          url,
        }:
        {
          definedAliases = [ alias ];
          inherit iconUpdateURL;
          updateInterval = 56 * 24 * 60 * 60 * 1000; # every 8 weeks
          urls = [
            {
              inherit params;
              template = url;
            }
          ];
        };
    in
    {
      "Bing".metaData.hidden = true;
      "Google".metaData.alias = "@g";
      "DuckDuckGo".metaData.alias = "@ddg";
    }
    # Nix stuff
    // {
      "Home Manager Options" = mkEngine {
        url = "https://home-manager-options.extranix.com";
        params = [
          {
            name = "query";
            value = "{searchTerms}";
          }
        ];
        iconUpdateURL = "https://home-manager-options.extranix.com/images/favicon.ico";
        alias = "@hmo";
      };

      "NixOS Options" = mkEngine {
        url = "https://search.nixos.org/options";
        params = [
          {
            name = "channel";
            value = "unstable";
          }
          {
            name = "query";
            value = "{searchTerms}";
          }
        ];
        iconUpdateURL = "https://nixos.org/favicon.ico";
        alias = "@no";
      };

      "Nix Packages" = mkEngine {
        url = "https://search.nixos.org/packages";
        params = [
          {
            name = "channel";
            value = "unstable";
          }
          {
            name = "query";
            value = "{searchTerms}";
          }
          {
            name = "type";
            value = "packages";
          }
        ];
        iconUpdateURL = "https://nixos.org/favicon.ico";
        alias = "@np";
      };

      "Nix PR Tracker" = mkEngine {
        url = "https://nixpkgs-tracker.ocfox.me";
        params = [
          {
            name = "pr";
            value = "{searchTerms}";
          }
        ];
        alias = "@pr";
      };

      "Source Graph" = mkEngine {
        url = "https://sourcegraph.com/search";
        params = [
          {
            name = "q";
            value = "context:@maan2003/nix {searchTerms}";
          }
          {
            name = "groupBy";
            value = "repo";
          }
        ];
        iconUpdateURL = "https://sourcegraph.com/favicon.ico";
        alias = "@sg";
      };
    }
    # Miscellaneous
    // {
      "discord.py" =
        let
          version = "latest";
        in
        mkEngine {
          url = "https://discordpy.readthedocs.io/en/${version}/search.html";
          params = [
            {
              name = "q";
              value = "{searchTerms}";
            }
          ];
          iconUpdateURL = "https://discordpy.readthedocs.io/en/stable/_static/discord_py_logo.ico";
          alias = "@dpy";
        };

      "Library Genesis" = mkEngine {
        url = "https://libgen.rs/search.php";
        params = [
          {
            name = "req";
            value = "{searchTerms}";
          }
        ];
        iconUpdateURL = "https://libgen.rs/favicon.ico";
        alias = "@libgen";
      };

      "MDN HTML" = mkEngine {
        url = "https://developer.mozilla.org/en-US/docs/Web/HTML/Element/{searchTerms}";
        iconUpdateURL = "https://developer.mozilla.org/favicon-48x48.png";
        alias = "@mdn";
      };

      "Proton DB" = mkEngine {
        url = "https://www.protondb.com/search";
        params = [
          {
            name = "q";
            value = "{searchTerms}";
          }
        ];
        alias = "@pdb";
      };

      "React Icons" = mkEngine {
        url = "https://react-icons.github.io/react-icons/search/#q={searchTerms}";
        alias = "@ri";
      };

      "Steam DB" = mkEngine {
        url = "https://steamdb.info/search";
        params = [
          {
            name = "a";
            value = "app";
          }
          {
            name = "type";
            value = "1";
          }
          {
            name = "q";
            value = "{searchTerms}";
          }
        ];
        alias = "@sdb";
      };

      "TailwindCSS" = mkEngine {
        url = "https://tailwindcss.com/docs/{searchTerms}";
        iconUpdateURL = "https://tailwindcss.com/favicons/favicon-16x16.png";
        alias = "@tw";
      };
    };
  force = true;
  order = [
    "DuckDuckGo"
    "Google"
  ];
}
