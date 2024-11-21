{ config, pkgs, ... }:
{
  home-manager.users.${config.mainuser} = {
    home.packages = [ pkgs.virt-manager ];

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
  persist.sysDataDirs = [ "/var/lib/libvirt" ];
}
