{ config, lib, ... }:
{
  imports = [
    ./firefox
    ./tools

    ./git.nix
    ./helix.nix
    ./libreoffice.nix
    ./shell.nix
    ./terminal.nix
    ./thunderbird.nix
  ];

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "22.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
