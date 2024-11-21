{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  persist.sysStateDirs = [ "/var/lib/tailscale" ];
}
