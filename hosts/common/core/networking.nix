{ hostName, lib, ... }:
{
  networking = {
    inherit hostName;
    hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
  persist.sysStateDirs = [ "/etc/NetworkManager" ];
}
