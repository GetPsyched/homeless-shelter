{ config, pkgs, ... }:
{
  home-manager.users.primary = {
    home.packages = [ pkgs.virt-manager ];

    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
  persist.data.directories = [ "/var/lib/libvirt" ];
}
