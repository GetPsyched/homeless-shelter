{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bottles
    gamemode
    heroic
    mangohud
    osu-lazer-bin
    protontricks
    qbittorrent
    winePackages.stagingFull
    winetricks
  ];

  # persist.misc.homeDirectories = [
  #   ".local/share/ATLauncher"
  #   ".local/share/Terraria"
  #   ".local/share/icons"
  #   ".heroic"
  #   ".steam-games"
  #   "bottles"
  #   "My Games"
  # ];
  # persist.state.homeDirectories = [
  #   ".config/heroic"
  #   ".local/share/applications"
  #   ".local/share/bottles"
  #   ".local/share/icons/hicolor"
  #   ".local/share/Terraria"
  #   ".local/share/wineprefixes"
  # ];

  programs.atlauncher = {
    enable = true;
    theme = "One Dark";

    settings = {
      enableConsole = false;
      enableTrayMenu = false;
      firstTimeRun = false;
      keepLauncherOpen = false;
      useJavaProvidedByMinecraft = false;
    };
  };
}
