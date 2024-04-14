{ config, lib, pkgs, ... }:
{
  imports = [
    ./firefox
    ./tools

    ./editor.nix
    ./git.nix
    ./libreoffice.nix
    ./shell.nix
    ./terminal.nix
    ./thunderbird.nix
  ];

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    pointerCursor = {
      name = "Banana";
      size = 48;
      package = pkgs.banana-cursor;
      x11.enable = true;
      gtk.enable = true;
    };
    stateVersion = "22.11";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
