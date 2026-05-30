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

  # FIXME https://github.com/tailscale/tailscale/issues/18381
  # services.tailscale.serve.enable = true;
  # services.tailscale.serve.services.immich = {
  #   endpoints."tcp:443" = "http://${config.services.immich.host}:${toString config.services.immich.port}";
  # };

  systemd.services.immich-tailscale-serve = {
    description = "Tailscale Service proxy for Immich";
    wantedBy = [ "multi-user.target" ];
    after = [
      "immich-server.service"
      "tailscaled.service"
    ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;

      ExecStart = builtins.concatStringsSep " " [
        "${config.services.tailscale.package}/bin/tailscale serve"
        "--service=svc:immich"
        "--https=443"
        "http://localhost:${toString config.services.immich.port}"
      ];
      ExecStop = "${config.services.tailscale.package}/bin/tailscale serve clear svc:immich";
    };
  };

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

  services.restic.backups.immich = {
    initialize = true;
    environmentFile = config.age.secrets.restic-env.path;
    repository = "s3:https://s3.eu-west-par.io.cloud.ovh.net/young-de-broglie/backups/services/immich";
    passwordFile = config.age.secrets.restic-pass.path;
    paths = [ config.services.immich.mediaLocation ];
    exclude = [
      "${config.services.immich.mediaLocation}/encoded-video"
      "${config.services.immich.mediaLocation}/thumbs"
    ];
  };

  age.secrets.restic-env.file = "${inputs.self}/secrets/restic/env.age";
  age.secrets.restic-pass = {
    file = "${inputs.self}/secrets/restic/pass.age";
    owner = config.services.restic.backups.immich.user;
  };
}
