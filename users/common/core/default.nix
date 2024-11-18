{ config, lib, ... }:
{
  imports = [
    ./firefox
    ./tools

    ./bash.nix
    ./direnv.nix
    ./git.nix
    ./helix.nix
    ./libreoffice.nix
    ./starship.nix
    ./terminal.nix
    ./thunderbird.nix
    ./tldr.nix
    ./zoxide.nix
  ];

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "22.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
