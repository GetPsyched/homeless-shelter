{ config, ... }:
{
  home-manager.users.primary.programs.bash = {
    enable = true;
  };
  persist.state.homeFiles = [ ".bash_history" ];
}
