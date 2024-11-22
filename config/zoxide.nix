{ config, ... }:
{
  home-manager.users.${config.mainuser}.programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };
  persist.state.homeDirectories = [ ".local/share/zoxide" ];
}
