{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lanzaboote.nixosModules.default
  ];

  environment.systemPackages = [ pkgs.sbctl ];

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # As of Lanzaboote v1.0.0, it replaces the systemd-boot module
  boot.loader.systemd-boot.enable = lib.mkForce false;

  persist.data.directories = [ "/var/lib/sbctl" ];
}
