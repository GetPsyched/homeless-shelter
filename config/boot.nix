{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # For unfortunate moments.
    supportedFilesystems.ntfs = true;
  };
}
