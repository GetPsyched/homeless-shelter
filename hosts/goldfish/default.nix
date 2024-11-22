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

    ../../config/user.nix
    ../../config/firefox
    ../../config/helix.nix
    ../../config/kitty.nix
    ../../config/i3.nix
    ../../config/hardware.nix
    ../../config/nix.nix
    ../../config/tailscale.nix
    ../../config/dconf.nix
    ../../config/locale.nix
    ../../config/networking.nix
  ];

  networking.wireless.enable = lib.mkForce false;

  # Remove broken zfs backage from the base ISO config
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/base.nix#L52-L54
  boot.supportedFilesystems = lib.mkForce [
    "btrfs"
    "cifs"
    "f2fs"
    "jfs"
    "ntfs"
    "reiserfs"
    "vfat"
    "xfs"
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "23.11";
}
