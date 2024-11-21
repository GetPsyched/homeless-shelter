{ hostName, lib, ... }:
{
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    hostName = hostName;
    hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);
  };
  persist.sysStateDirs = [ "/etc/NetworkManager" ];
}
