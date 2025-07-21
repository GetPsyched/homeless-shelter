{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [
    bottles
    gamemode
    heroic
    osu-lazer-bin
    protontricks
    qbittorrent
    winePackages.stagingFull
    winetricks
  ];
  persist.state.homeDirectories = [
    ".config/heroic"
    ".local/share/bottles"
    ".local/share/wineprefixes"
  ];
  persist.misc.homeDirectories = [
    ".heroic"
    "bottles"
    "games"
  ];

  allowUnfreePackages = [ "osu-lazer-bin" ];
}
