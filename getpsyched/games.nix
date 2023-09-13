{ pkgs, config, inputs, ... }:
{
  home.packages = with pkgs; [
    atlauncher
    gamemode
    heroic
    mangohud
    osu-lazer-bin
  ];

  xdg.desktopEntries = {
    rocket-league = {
      categories = [ "Game" ];
      exec = "xdg-open heroic://launch/legendary/Sugar";
      icon = "/home/getpsyched/.config/heroic/icons/Sugar.jpg";
      name = "Rocket League";
      terminal = false;
      type = "Application";
    };
  };
}
