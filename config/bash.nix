{ config, ... }:
{
  home-manager.users.${config.mainuser} = {
    programs.bash.enable = true;
    persist.stateFiles = [ ".bash_history" ];
  };
}
