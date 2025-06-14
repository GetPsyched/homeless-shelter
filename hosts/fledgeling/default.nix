{ config, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/bash.nix
    ../../config/core.nix
    ../../config/home.nix
    ../../config/immich.nix
    ../../config/starship.nix
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
      reverse_proxy localhost:${toString config.services.immich-public-proxy.port}
    '';
    "immich.internal.getpsyched.dev".extraConfig = ''
      encode zstd gzip
      reverse_proxy localhost:${toString config.services.immich.port}
    '';
  };

  time.timeZone = "Europe/Berlin";
}
