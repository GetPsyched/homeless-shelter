{ config, ... }:
{
  persist.sysDataDirs = [ "/etc/ssh" ];
  home-manager.users.${config.mainuser}.persist.secretsDirs = [ ".ssh" ];
}
