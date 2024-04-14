{ hostName, inputs, lib, pkgs, ... }:
{
  isoImage.isoName = lib.mkForce "${hostName}.iso";
  isoImage.volumeID = lib.mkForce hostName;

  imports = [
    (inputs.nixpkgs + "/nixos/modules/installer/cd-dvd/installation-cd-base.nix")

    ../common/core
    ../common/optional/display-manager.nix
    ../common/optional/xserver.nix
  ];

  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "23.11";
}
