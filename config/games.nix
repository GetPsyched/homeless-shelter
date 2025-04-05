{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [
    bottles
    gamemode
    legendary-heroic
    osu-lazer-bin
    protontricks
    qbittorrent
    winePackages.stagingFull
    winetricks
  ];
  persist.state.homeDirectories = [
    ".config/legendary"
    ".local/share/bottles"
    ".local/share/wineprefixes"
  ];
  persist.misc.homeDirectories = [ "bottles" ];

  allowUnfreePackages = [ "osu-lazer-bin" ];
}
