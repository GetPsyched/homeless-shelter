{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    gamemode
    mangohud
    osu-lazer-bin

    (callPackage ../packages/atlauncher.nix { })
  ];
}
