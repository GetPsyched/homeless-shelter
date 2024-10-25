{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.syncthing ];
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };

  persist.sysDataDirs = [ "/var/lib/syncthing" ];
}
