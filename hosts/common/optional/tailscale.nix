{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.tailscale ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  persist.sysStateDirs = [ "/var/lib/tailscale" ];
}
