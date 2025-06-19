{
  hostName,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  isoImage = {
    configurationName = hostName;
    edition = "custom";
    isoName = "${hostName}.iso";
    volumeID = hostName;
  };

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"

    ../../config/core.nix
    ../../config/dconf.nix
    ../../config/direnv.nix
    ../../config/firefox.nix
    ../../config/flameshot.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/home.nix
    ../../config/i3.nix
    ../../config/kitty.nix
    ../../config/locale.nix
    ../../config/networking.nix
    ../../config/rofi
    ../../config/zsh.nix
  ];

  environment.systemPackages = [ pkgs.gparted ];
  users.users.primary.packages = [ pkgs.wifi-qr ];

  networking.wireless.enable = lib.mkForce false;

  # Remove broken zfs backage from the base ISO config
  boot.supportedFilesystems.zfs = lib.mkForce false;
}
