{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };
  persist.state.directories = [ "/var/lib/tailscale" ];

  networking.firewall.trustedInterfaces = [ "tailscale0" ];
}
