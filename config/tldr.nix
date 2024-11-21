{ config, ... }:
{
  home-manager.users.${config.mainuser}.programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true;
  };
}
