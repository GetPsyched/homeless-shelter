{ config, lib, ... }:
{
  home = {
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = "24.11";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
