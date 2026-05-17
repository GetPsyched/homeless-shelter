{ config, inputs, ... }:
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
    settings.ipp = {
      allowDownloadAll = 1;
      showGalleryTitle = true;
    };
  };

  services.restic.backups.immich = {
    initialize = true;
    environmentFile = config.age.secrets.restic-env.path;
    repository = "s3:https://s3.eu-west-par.io.cloud.ovh.net/young-de-broglie/backups/services/immich";
    passwordFile = config.age.secrets.restic-immich-pass.path;
    paths = [ config.services.immich.mediaLocation ];
    exclude = [
      "${config.services.immich.mediaLocation}/encoded-video"
      "${config.services.immich.mediaLocation}/thumbs"
    ];
  };

  age.secrets.restic-env.file = "${inputs.self}/secrets/restic/env.age";
  age.secrets.restic-immich-pass = {
    file = "${inputs.self}/secrets/restic/immich/pass.age";
    owner = config.services.restic.backups.immich.user;
  };
}
