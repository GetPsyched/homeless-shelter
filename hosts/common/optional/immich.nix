{ config, ... }:
{
  services.immich = {
    enable = true;
    host = "0.0.0.0";
  };
  persist.data.directories = [ config.services.immich.mediaLocation ];
}
