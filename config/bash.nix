{ config, ... }:
{
  home-manager.users.${config.mainuser}.programs.bash = {
    enable = true;
  };
  persist.state.homeFiles = [ ".bash_history" ];
}
