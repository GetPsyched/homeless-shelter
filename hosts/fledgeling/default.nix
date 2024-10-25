{ config, ... }:
{
  imports = [
    ../common/core
    ./hardware-configuration.nix

    ../common/optional/immich.nix
    ../common/optional/syncthing.nix
  ];

  users.users.root.hashedPassword = "$y$j9T$xg0X2wgh7cke3y.42NiDw0$VQoyREzlRwxySHRSW1Sfi.cDUhjoPNVLS76MDes01o6";

  documentation.nixos.enable = false;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.caddy.enable = true;
  services.caddy.virtualHosts = {
    "immich.getpsyched.dev".extraConfig = ''
      encode zstd gzip
      reverse_proxy localhost:${toString config.services.immich.port}
    '';
  };

  services.syncthing.settings.folders = {
    "immich" = {
      path = config.services.immich.mediaLocation;
      type = "sendonly";
      devices = [ "piglin" ];
    };
  };

  time.timeZone = "Europe/Berlin";
  system.stateVersion = "24.05";
}
