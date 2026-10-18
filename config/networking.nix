{
  config,
  lib,
  ...
}: {
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    hostId = builtins.substring 0 8 (builtins.hashString "md5" config.networking.hostName);
  };
  persist.state.directories = ["/etc/NetworkManager/system-connections"];
}
