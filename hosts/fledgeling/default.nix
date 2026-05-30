{ hostName, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ../../config/core.nix
    ../../config/immich.nix
    ../../config/zsh.nix
  ];

  documentation.nixos.enable = false;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.caddy.enable = true;

  networking.hostName = hostName;
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

  time.timeZone = "Europe/Berlin";
}
