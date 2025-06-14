{ config, ... }:
{
  services.immich = {
    enable = true;
    host = "0.0.0.0";

    settings = {
      server.externalDomain = "https://immich.getpsyched.dev";
    };
  };
  persist.data.directories = [ config.services.immich.mediaLocation ];

  services.immich-public-proxy = {
    enable = true;
    immichUrl = "https://immich.internal.getpsyched.dev";
    port = 2284;
  };
}
