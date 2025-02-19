{ inputs, ... }:
{
  imports = [ "${inputs.nixos-hardware}/starfive/visionfive/v2/sd-image-installer.nix" ];
  sdImage.compressImage = false;
}
