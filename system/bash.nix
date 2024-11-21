{ config, ... }:
{
  home-manager.users.${config.mainuser} = {
    programs.bash.enable = true;
    persist.stateDirs = [ ".bash_history" ];
  };
}
