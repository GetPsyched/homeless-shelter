{ config, ... }:
{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
  };

  persist.sysDataDirs = [ config.services.immich.mediaLocation ];
}
