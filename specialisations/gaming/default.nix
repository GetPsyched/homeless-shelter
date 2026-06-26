{ pkgs, ... }:
{
  specialisation.gaming.configuration = {
    imports = [
      ./atlauncher.nix
      ./hydra.nix
      ./steam.nix
    ];

    users.users.primary.packages = with pkgs; [
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
      ".local/share/wineprefixes"
    ];
    persist.misc.homeDirectories = [
      ".heroic"
      "games"
    ];
  };

  nixpkgs.config.allowUnfreePackages = [ "osu-lazer-bin" ];
}
