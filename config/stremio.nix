{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [ stremio ];
  allowUnfreePackages = [
    "stremio-server"
    "stremio-shell"
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
}
