{ lib, ... }:
{
  persist.stateDirs = [ ".local/share/activitywatch" ];

  services.activitywatch = {
    enable = true;
  };
  systemd.user.services.activitywatch.Service.Restart = lib.mkForce "always";
  systemd.user.services.activitywatch-watcher-awatcher.Service.Restart = lib.mkForce "always";
}
