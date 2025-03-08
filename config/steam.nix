{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];

  persist.state.homeDirectories =
    [
      ".local/share/applications"
      ".local/share/icons/hicolor"
      ".steam"
    ]
    # Games config
    ++ [
      ".local/share/Terraria"
    ];
  persist.misc.homeDirectories = [ ".local/share/Steam" ];
}
