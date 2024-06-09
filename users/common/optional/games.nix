{ inputs, pkgs, ... }:
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

  persist.gameDirs = [
    ".local/share/ATLauncher"
    ".local/share/Terraria"
    ".local/share/icons"
    ".heroic"
    ".steam-games"
    "bottles"
    "My Games"
  ];
  persist.stateDirs = [
    ".config/heroic"
    ".local/share/applications"
    ".local/share/bottles"
    ".local/share/wineprefixes"
  ];

  programs.atlauncher = {
    enable = true;
    package = (pkgs.callPackage ../../../packages/atlauncher.nix {
      buildGradlePackage = inputs.gradle2nix.builders.x86_64-linux.buildGradlePackage;
    });

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
