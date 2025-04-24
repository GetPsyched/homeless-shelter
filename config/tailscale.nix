{ config, ... }:
{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
  persist.state.directories = [ "/var/lib/tailscale" ];

  networking.firewall.trustedInterfaces = [ config.services.tailscale.interfaceName ];
}
