{
  hostName,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  isoImage.isoName = lib.mkForce "${hostName}.iso";
  isoImage.volumeID = lib.mkForce hostName;

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"

    ../../config/bash.nix
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
  ];

  users.users.primary.packages = [ pkgs.wifi-qr ];

  networking.wireless.enable = lib.mkForce false;

  # Remove broken zfs backage from the base ISO config
  boot.supportedFilesystems.zfs = lib.mkForce false;
}
