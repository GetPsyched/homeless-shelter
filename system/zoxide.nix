{ config, ... }:
{
  home-manager.users.${config.mainuser} = {
    programs.zoxide = {
      enable = true;
      options = [ "--cmd cd" ];
    };
    persist.stateDirs = [ ".local/share/zoxide" ];
  };
}
