{ pkgs, ... }:
{
  boot = {
    # piglin failed to boot with 6.17.3
    kernelPackages = pkgs.linuxPackages_6_16;

    # For unfortunate moments.
    supportedFilesystems.ntfs = true;
  };
}
