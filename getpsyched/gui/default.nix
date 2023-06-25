{ pkgs, ... }:
{
  imports = [
    ./i3.nix
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

  services.random-background = {
    enable = true;
    imageDirectory = "%h/backgrounds";
  };
}
