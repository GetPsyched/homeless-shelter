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

  services.caddy.virtualHosts."immich.internal.getpsyched.dev".extraConfig = ''
    encode zstd gzip
    reverse_proxy ${config.services.immich.host}:${toString config.services.immich.port}
  '';

  services.immich-public-proxy = {
    enable = true;
    immichUrl = "https://immich.internal.getpsyched.dev";
    port = 2284;
    settings.ipp = {
      allowDownloadAll = 1;
      showGalleryTitle = true;
    };
  };

  services.caddy.virtualHosts."immich.getpsyched.dev".extraConfig = ''
    encode zstd gzip
    reverse_proxy localhost:${toString config.services.immich-public-proxy.port}
  '';
}
