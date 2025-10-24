{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [ winboat ];

  virtualisation.docker.enable = true;
  users.users.primary.extraGroups = [ "docker" ];

  persist.state.homeDirectories = [
    ".config/winboat"
    ".local/state/winboat"
    ".winboat"
  ];
}
