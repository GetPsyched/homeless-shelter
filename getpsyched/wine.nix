{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottles
    winePackages.stagingFull
    winetricks
  ];
}
