{
  hostName,
  lib,
  modulesPath,
  ...
}:
{
  isoImage.isoName = lib.mkForce "${hostName}.iso";
  isoImage.volumeID = lib.mkForce hostName;

  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"

    ../../config/bash.nix
    ../../config/boot.nix
    ../../config/dconf.nix
    ../../config/direnv.nix
    ../../config/core.nix
    ../../config/firefox.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/home.nix
    ../../config/i3.nix
    ../../config/kitty.nix
    ../../config/locale.nix
    ../../config/networking.nix
    ../../config/rofi
  ];

  networking.wireless.enable = lib.mkForce false;

  # Remove broken zfs backage from the base ISO config
  boot.supportedFilesystems.zfs = lib.mkForce false;
}
