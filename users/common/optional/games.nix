{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gamemode
    heroic
    mangohud
    osu-lazer-bin
  ];

  persist.gameDirs = [
    ".local/share/ATLauncher"
    ".heroic"
    ".steam-games"
    "My Games"
  ];
  persist.stateDirs = [ ".config/heroic" ".local/share/applications" ];

  programs.atlauncher = {
    enable = true;
    theme = "One Dark";

    settings = {
      enableConsole = false;
      enableTrayMenu = false;
      firstTimeRun = false;
      keepLauncherOpen = false;
    };
  };

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
