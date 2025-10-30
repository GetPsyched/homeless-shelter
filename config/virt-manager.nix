{ pkgs, ... }:
{
  hjem.users.primary.packages = [ pkgs.virt-manager ];

  # home-manager.users.primary = {
  #   dconf.settings = {
  #     "org/virt-manager/virt-manager/connections" = {
  #       autoconnect = [ "qemu:///system" ];
  #       uris = [ "qemu:///system" ];
  #     };
  #   };
  # };
  persist.data.directories = [ "/var/lib/libvirt" ];
}
