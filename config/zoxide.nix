{ config, ... }:
{
  home-manager.users.primary.programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
  persist.state.homeDirectories = [ ".local/share/zoxide" ];
}
