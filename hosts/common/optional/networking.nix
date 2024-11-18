{ lib, ... }:
{
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
  persist.state.directories = [ "/etc/NetworkManager/system-connections" ];
}
