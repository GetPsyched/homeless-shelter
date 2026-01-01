{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  hjem.users.primary.rum.desktops.i3.commands = ''
    exec --no-startup-id i3-msg 'workspace 1; exec ${lib.getExe config.programs.steam.package}'
  '';

  allowUnfreePackages = [
    "steam"
    "steam-unwrapped"
  ];

  persist.state.homeDirectories = [
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
