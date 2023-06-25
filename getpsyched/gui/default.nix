{ pkgs, ... }:
{
  imports = [
    ./i3.nix
    ./konsole.nix
    ./screen-capture.nix
    # ./theme.nix
  ];

  programs.feh.enable = true;

  services.random-background = {
    enable = true;
    imageDirectory = "%h/backgrounds";
  };
}
