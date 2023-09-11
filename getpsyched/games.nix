{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    atlauncher
    gamemode
    mangohud
    osu-lazer-bin
  ];
}
