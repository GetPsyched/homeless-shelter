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
    requires = [ "tailscaled.service" ];

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
}
