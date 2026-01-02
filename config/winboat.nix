{
  hjem.users.primary.rum.programs.winboat.enable = true;

  virtualisation.docker.enable = true;
  users.users.primary.extraGroups = [ "docker" ];

  persist.state.homeDirectories = [
    ".config/winboat"
    ".local/state/winboat"
    ".winboat"
  ];
}
