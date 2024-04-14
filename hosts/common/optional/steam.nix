{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  allowUnfreePackages = [
    "steam"
    "steam-original"
    "steam-run"
  ];
}
