{ pkgs, ... }:
{
  boot = {
    # FIXME: https://github.com/NixOS/nixpkgs/issues/357643
    # kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxKernel.packages.linux_6_11;

    # For unfortunate moments.
    supportedFilesystems = [ "ntfs" ];
  };
}
