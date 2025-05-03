{ inputs, ... }:
{
  imports = [ "${inputs.nixos-hardware}/starfive/visionfive/v2/sd-image-installer.nix" ];
  sdImage.compressImage = false;
  nixpkgs.buildPlatform = "x86_64-linux";
}
