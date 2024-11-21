{ config, lib, ... }:
{
  home-manager.users.${config.mainuser} = {
    services.activitywatch = {
      enable = true;
    };
    persist.stateDirs = [ ".local/share/activitywatch" ];

    systemd.user.services.activitywatch.Service.Restart = lib.mkForce "always";
    systemd.user.services.activitywatch-watcher-awatcher.Service.Restart = lib.mkForce "always";
  };
}
