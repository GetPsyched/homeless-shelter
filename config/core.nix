{ system, ... }:
{
  persist.cache.directories = [
    "/var/cache"
    "/var/tmp"
  ];

  nixpkgs.hostPlatform = system;
  system.stateVersion = "25.05";
}
