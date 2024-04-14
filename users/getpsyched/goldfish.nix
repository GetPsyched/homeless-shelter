{ config, inputs, pkgs, ... }:
{
  imports = [
    ../../modules/home-manager

    ../common/core
    ../common/optional/i3.nix
  ];

  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  home = {
    username = "getpsyched";
    packages = [ pkgs.gparted ];
  };
}
