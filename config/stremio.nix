{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [ stremio-linux-shell ];
  nixpkgs.config.allowUnfreePackages = [ "stremio-linux-shell" ];

  persist.data.homeDirectories = [
    ".local/share/stremio"
    ".stremio-server"
  ];
  persist.cache.homeDirectories = [ ".cache/stremio-cache" ];
}
