{ pkgs, ... }:
{
  imports = [
    ./screen-capture.nix
    ./konsole.nix
    ./sway
    # ./theme.nix
  ];

  services.random-background = {
    enable = true;
    imageDirectory = "%h/backgrounds";
  };
}
