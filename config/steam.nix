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
