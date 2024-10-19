{
  imports = [ ./hardware-configuration.nix ];

  documentation.nixos.enable = false;

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  time.timeZone = "Europe/Berlin";
  system.stateVersion = "24.05";
}
