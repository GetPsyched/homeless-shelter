{ pkgs, ... }:
{
  users.users.primary.packages = [ pkgs.hytale-launcher ];

  persist.data.homeDirectories = [
    ".local/share/Hytale"
    ".local/share/hytale-launcher"
  ];

  nixpkgs.config.allowUnfreePackages = [ "hytale-launcher" ];
}
