{ pkgs, ... }:
{
  imports = [
    ./screen-capture.nix
  ];

  home.pointerCursor = {
    name = "Banana";
    size = 48;
    package = (pkgs.callPackage ../../packages/banana-cursor.nix { });
    x11.enable = true;
    gtk.enable = true;
  };

  programs.feh.enable = true;

  services.gammastep = {
    enable = true;
    temperature.day = 4500;
    temperature.night = 4500;
    duskTime = "18:35-20:15";
    dawnTime = "6:00-7:45";
  };

  services.random-background = {
    enable = true;
    imageDirectory = "%h/backgrounds";
    interval = "1h";
  };
}
