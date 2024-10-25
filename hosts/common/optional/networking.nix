{ lib, ... }:
{
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
  persist.sysStateDirs = [ "/etc/NetworkManager" ];
}
