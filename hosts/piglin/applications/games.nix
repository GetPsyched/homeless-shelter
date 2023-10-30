{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gamemode
    heroic
    mangohud
    osu-lazer-bin
  ];

  programs.atlauncher = {
    enable = true;
    package = (pkgs.callPackage ../../../packages/atlauncher.nix { });

    theme = "One Dark";

    settings = {
      enableConsole = false;
      enableTrayMenu = false;
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
