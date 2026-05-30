{
  config,
  hostName,
  inputs,
  lib,
  modulesPath,
  pkgs,
  ...
}:
let
  immich = config.services.immich;
  resticImmich = config.services.restic.backups.immich;
in
{
  imports = [
    "${modulesPath}/virtualisation/qemu-vm.nix"

    ../../config/core.nix
    ../../config/immich.nix
    ../../config/zsh.nix
  ];

  documentation.nixos.enable = false;

  # Re-register on every boot using the ephemeral key so the test node is
  # garbage-collected by the Tailscale control plane shortly after teardown.
  services.tailscale.authKeyFile = lib.mkForce config.age.secrets.tailscale-ephemeral.path;
  services.tailscale.authKeyParameters.ephemeral = lib.mkForce true;

  age.secrets.tailscale-ephemeral = {
    file = "${inputs.self}/secrets/tailscale-ephemeral.age";
    owner = config.users.users.primary.name;
    group = config.users.users.primary.group;
  };

  # Phoenix regenerates its SSH host keys on every boot, so they aren't enrolled
  # in keys.nix and agenix can't decrypt anything with them. Forward the
  # operator's ~/.ssh from the source machine via 9p and use a user key
  # (which *is* in keys.nix) as the agenix identity instead. We rely on the
  # convention that the source host's primary user matches the guest's, so the
  # path resolves identically on both sides — override `source` if not.
  virtualisation.sharedDirectories.host-ssh = {
    source = "${config.users.users.primary.home}/.ssh";
    target = "/run/host-ssh";
    securityModel = "none";
  };
  age.identityPaths = [ "/run/host-ssh/id_ed25519" ];

  # We're verifying that the latest backup is restorable, not pushing a new one.
  systemd.timers.restic-backups-immich.enable = false;

  # immich-public-proxy fronts a public hostname that resolves to the real host;
  # the test VM has no reason (or way) to participate.
  services.immich-public-proxy.enable = lib.mkForce false;

  # Immich's UI-driven "restore from backup" flow runs `pg_dumpall`-style SQL
  # through psql as the unprivileged immich role; the dump re-issues
  # `CREATE EXTENSION earthdistance` (not a trusted extension), which requires
  # superuser. Granting it on this disposable VM keeps the restore flow from
  # tripping. Don't propagate this to fledgeling.
  services.postgresql.ensureUsers = [
    {
      name = config.services.immich.database.user;
      ensureClauses.superuser = true;
    }
  ];

  systemd.services.immich-restore = {
    description = "Restore Immich media from the OVH restic repository";

    requiredBy = [ "immich-server.service" ];
    before = [ "immich-server.service" ];
    after = [ "network-online.service" ];
    wants = [ "network-online.service" ];

    path = [ pkgs.restic ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      EnvironmentFile = config.age.secrets.restic-env.path;
    };

    script = ''
      set -euo pipefail

      stamp=${immich.mediaLocation}/.restored
      if [ -e "$stamp" ]; then
        echo "Restore stamp $stamp present; skipping."
        exit 0
      fi

      mkdir -p ${immich.mediaLocation}
      restic \
        -r ${lib.escapeShellArg resticImmich.repository} \
        --password-file ${resticImmich.passwordFile} \
        restore latest --target /

      touch "$stamp"
    '';
  };

  virtualisation = {
    cores = 4;
    memorySize = 4096;
    diskSize = 64 * 1024;
    graphics = false;
    forwardPorts = [
      {
        from = "host";
        host.port = 2283;
        guest.port = immich.port;
      }
    ];
  };

  networking.hostName = hostName;
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

  time.timeZone = "Europe/Berlin";
}
