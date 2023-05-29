{ pkgs, ... }:
{
  imports = [
    ./screen-capture.nix
    ./konsole.nix
    ./sway
    # ./theme.nix
  ];

  programs.feh.enable = true;

  services.random-background = {
    enable = true;
    imageDirectory = "%h/backgrounds";
  };
}
