{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    # For unfortunate moments.
    supportedFilesystems = [ "ntfs" ];
  };

  hardware.bluetooth.enable = true;

  services.libinput.touchpad.naturalScrolling = true;
}
