{ pkgs, ... }:
{
  imports = [
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./tealdeer.nix
    ./terminal.nix
  ];

  home.packages = with pkgs; [
    postgresql
    sqlitebrowser
    virt-manager
  ];

  # For virt-manager
  dconf = {
    enable = true;
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}
