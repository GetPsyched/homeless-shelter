{ config, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];

  home-manager.users.${config.mainuser} = {
    persist.stateDirs =
      [
        ".local/share/applications"
        ".local/share/icons"
        ".local/share/Steam"
        ".steam"
      ]
      # Games config
      ++ [
        ".local/share/Terraria"
      ];
    persist.gameDirs = [ ".steam-games" ];
  };
}
