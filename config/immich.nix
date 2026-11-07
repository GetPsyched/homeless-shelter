{
  config,
  pkgs,
  ...
}: {
  services.immich = {
    enable = true;
    host = "0.0.0.0";

    settings = {
      server.externalDomain = "https://immich.getpsyched.dev";
    };
  };
  persist.data.directories = [config.services.immich.mediaLocation config.services.postgresql.dataDir];

  # FIXME https://github.com/tailscale/tailscale/issues/18381
  # services.tailscale.serve.enable = true;
  # services.tailscale.serve.services.immich = {
  #   endpoints."tcp:443" = "http://${config.services.immich.host}:${toString config.services.immich.port}";
  # };

  systemd.services.immich-tailscale-serve = {
    description = "Tailscale Service proxy for Immich";
    wantedBy = ["multi-user.target"];
    after = [
      "immich-server.service"
      "tailscaled.service"
    ];
    requires = ["tailscaled.service"];

    path = [config.services.tailscale.package pkgs.jq];
    preStart = ''
      for i in $(seq 1 30); do
        state=$(tailscale status --json --peers=false 2>/dev/null | jq -r .BackendState || true)
        [ "$state" = "Running" ] && exit 0
        echo "tailscale not Running (last state: ''${state:-unreachable})" >&2
        sleep 1
      done
      exit 1
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";

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
