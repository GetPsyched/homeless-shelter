{ pkgs, ... }:
{
  specialisation.gaming.configuration = {
    imports = [
      ./atlauncher.nix
      ./hydra.nix
      ./steam.nix
    ];

    users.users.primary.packages = with pkgs; [
      # bottles
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
  };

  nixpkgs.config.allowUnfreePackages = [ "osu-lazer-bin" ];
}
