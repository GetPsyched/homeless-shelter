{
  config,
  pkgs,
  ...
}: {
  users.users.actual = {
    group = config.users.groups.actual.name;
    isSystemUser = true;
  };
  users.groups.actual = {};

  services.actual = {
    enable = true;

    user = config.users.users.actual.name;
    group = config.users.users.actual.group;
  };

  persist.data.directories = [config.services.actual.settings.dataDir];

  # FIXME https://github.com/tailscale/tailscale/issues/18381
  # services.tailscale.serve.enable = true;
  # services.tailscale.serve.services.actual = {
  #   endpoints."tcp:443" = "http://${config.services.actual.settings.hostname}:${toString config.services.actual.settings.port}";
  # };

  systemd.services.actual-tailscale-serve = {
    description = "Tailscale Service proxy for ActualBudget";
    wantedBy = ["multi-user.target"];
    after = [
      "actual.service"
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
        "--service=svc:actual"
        "--https=443"
        "http://localhost:${toString config.services.actual.settings.port}"
      ];
      ExecStop = "${config.services.tailscale.package}/bin/tailscale serve clear svc:actual";
    };
  };
}
