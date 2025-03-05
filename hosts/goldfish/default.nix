{
  hostName,
  inputs,
  lib,
  ...
}:
{
  isoImage.isoName = lib.mkForce "${hostName}.iso";
  isoImage.volumeID = lib.mkForce hostName;

  imports = [
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-base.nix")

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
    ../../config/nix.nix
    ../../config/networking.nix
    ../../config/rofi
    ../../config/starship.nix
    ../../config/tailscale.nix
    ../../config/user.nix
  ];

  networking.wireless.enable = lib.mkForce false;

  # Remove broken zfs backage from the base ISO config
  boot.supportedFilesystems.zfs = lib.mkForce false;
}
