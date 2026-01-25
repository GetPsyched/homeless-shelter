{ pkgs, ... }:
{
  users.users.primary.packages = [ pkgs.hydralauncher ];
  persist.state.homeDirectories = [ ".config/hydralauncher" ];
}
