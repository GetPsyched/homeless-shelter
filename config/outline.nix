{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.outline = {
    enable = true;
    publicUrl = "http://localhost:3003";
    port = 3003;
    forceHttps = false;
    storage.storageType = "local";
    oidcAuthentication = {
      # Parts taken from
      # http://dex.localhost/.well-known/openid-configuration
      authUrl = "http://dex.localhost/auth";
      tokenUrl = "http://dex.localhost/token";
      userinfoUrl = "http://dex.localhost/userinfo";
      clientId = "outline";
      clientSecretFile = (builtins.elemAt config.services.dex.settings.staticClients 0).secretFile;
      scopes = [
        "openid"
        "email"
        "profile"
      ];
      usernameClaim = "preferred_username";
      displayName = "Dex";
    };
  };

  services.dex = {
    enable = true;
    settings = {
      issuer = "http://dex.localhost";
      storage.type = "sqlite3";
      web.http = "127.0.0.1:5556";
      enablePasswordDB = true;
      staticClients = [
        {
          id = "outline";
          name = "Outline Client";
          redirectURIs = [ "${config.services.outline.publicUrl}/auth/oidc.callback" ];
          secretFile = "${pkgs.writeText "outline-oidc-secret" "test123"}";
        }
      ];
      staticPasswords = [
        {
          email = "user.email@example.com";
          # bcrypt hash of the string "password": $(echo password | htpasswd -BinC 10 admin | cut -d: -f2)
          hash = "$2b$12$6oMYbc6j4YNKjtLe0TnobuPifs/2AYV1hxtJN1SGFZBHScoLs6zUu";
          username = "test";
          # easily generated with `$ uuidgen`
          userID = "6D196B03-8A28-4D6E-B849-9298168CBA34";
        }
      ];
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts = {
      "localhost" = {
        locations."/" = {
          proxyPass = "${config.services.outline.publicUrl}";
        };
      };
      "dex.localhost" = {
        locations."/" = {
          proxyPass = "http://${config.services.dex.settings.web.http}";
        };
      };
    };
  };

  allowUnfreePackages = [ "outline" ];
  persist.sysDataDirs = lib.mkIf (config.services.outline.storage.storageType == "local") [
    config.services.outline.storage.localRootDir
  ];
}
