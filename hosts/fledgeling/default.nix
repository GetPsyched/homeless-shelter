{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../system/user.nix
    ../../system/hardware.nix
    ../../system/nix.nix
    ../../system/tailscale.nix
    ../../system/immich.nix
  ];

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

  time.timeZone = "Europe/Berlin";
  system.stateVersion = "24.05";
}
