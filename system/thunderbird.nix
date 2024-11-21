{ config, ... }:
{
  home-manager.users.${config.mainuser} = {
    programs.thunderbird = {
      enable = true;

      profiles.main = {
        isDefault = true;
      };
    };
    persist.stateDirs = [ ".thunderbird/main" ];
  };
}
