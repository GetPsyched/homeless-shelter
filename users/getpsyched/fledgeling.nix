{ config, lib, ... }:
{
  imports = [ ../../modules/home-manager ];

  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
