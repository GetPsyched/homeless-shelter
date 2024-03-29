{ pkgs, ... }:
{
  imports = [
    ./editor.nix
    ./git.nix
    ./shell.nix
    ./terminal.nix
  ];

  home.packages = with pkgs; [
    sqlitebrowser
    virt-manager
  ];

  persist.stateDirs = [ ".rustup" ];
  persist.stateFiles = [ ".railway/config.json" ];

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
